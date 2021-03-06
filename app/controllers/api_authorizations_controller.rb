class ApiAuthorizationsController < ApplicationController
  before_action :authenticate, only: [:create, :import, :authorize]
  include QuizletApiHelper

  def create
    auth = QuizletApiHelper.authorization_redirect
    session[:quizlet_state] = auth[:state]
    redirect_to auth[:redirect]
  end

  def import
    api  = params[:api]
    type = params[:type]
    if api == 'quizlet' and type == 'classrooms'
      path = "users/#{current_admin.username}/groups"
      quizlet_classrooms = QuizletApiHelper.get_response(path, current_admin)
      quizlet_classrooms.each do |quizlet_classroom|
        model_data = {
          name: quizlet_classroom['name'],
          quizlet_id: quizlet_classroom['id'],
          admin_id: current_admin.id
        }
        classroom = Classroom.find_or_create_by(model_data)
        classroom.update_attributes model_data
      end

      return redirect_to classrooms_path, notice: t(:imported_classrooms)
    else if api == 'quizlet' and type == 'students'
      path = "users/#{current_admin.username}/groups"
      quizlet_classrooms = QuizletApiHelper.get_response(path, current_admin)
      quizlet_classrooms.each do |quizlet_classroom|
        students  = quizlet_classroom['members']
        classroom = Classroom.find_or_create_by(quizlet_id: quizlet_classroom['id'])
        students.each do |student|
          next if student['role'] == 'admin'
          student_ar = Student.find_or_create_by(username: student['username'])
          student_ar.classrooms << classroom unless student_ar.classrooms.include?(classroom)
        end
      end
      return redirect_to students_path, notice: t(:imported_students)
    end

      redirect_to root_path, notice: t(:undefined_import)
    end
  end

  def authorize
    quizlet_state = params[:state]
    quizlet_code  = params[:code]
    if session[:quizlet_state] == quizlet_state
      QuizletApiHelper.request_token(quizlet_code, current_admin[:id])
      redirect_to root_path, notice: t(:authorized_api)
    else
      redirect_to root_path, notice: t(:failed_authorization)
    end
  end

  private
  def authenticate
    redirect_to root_path, alert: "Not authorized" unless current_admin
  end
end
