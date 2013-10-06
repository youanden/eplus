class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:grade_assignment, :grade_student, :show, :edit, :update, :destroy]
  before_action :authenticate, only: [:index, :show, :edit, :update, :destroy]
  include QuizletApiHelper

  def grade_assignment
    @assignment.classroom.students.each do |student|
      study_sessions = QuizletApiHelper.get_response("users/#{student.username}/studied", current_admin)
      study_sessions.each do |study_session|
        next if study_session['mode'] == 'flashcards'
        next if study_session['mode'] == 'test'
        if study_session['set']['id'] == @assignment.quizlet_id
          model_data = {
            student_id: student.id,
            assignment_id: @assignment.id,
            mode: study_session['mode']
          }
          # raise "T" if study_session['mode'] == "spacerace"
          if study_session['formatted_score']
            model_data['score'] = study_session['formatted_score']
          elsif study_session['finish_date']
            model_data['finish_date'] = DateTime.strptime(study_session['finish_date'].to_s, "%s")
            model_data['value'] = @assignment.value
          else
            model_data['value'] = 0
          end

          grade = Grade.find_or_create_by model_data
          grade.update_attributes model_data
          grade.save
          # student.grades << grade
        end
      end
    end

    redirect_to @assignment, notice: t(:assignment_graded)
  end

  def grade_student
    student_id = params[:student_id]
    grade_value = params[:grade].to_i
    if grade_value > @assignment.value
      grade_value = @assignment.value
    elsif grade_value < 0
      grade_value = 0
    end
    grade = Grade.find_or_create_by assignment_id: @assignment.id, student_id: student_id
    grade.update_attributes value: grade_value
    if grade.save
      render text: 1
    else
      render text: 0
    end
  end

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  # POST /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.admin_id = current_admin[:id]

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: 'Assignment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @assignment }
      else
        format.html { render action: 'new' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to assignments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:name, :value, :due_date, :classroom_id, :quizlet_id)
    end

    def authenticate
      redirect_to root_path, alert: "Not authorized" unless current_admin
    end
end
