class ApiAuthorizationsController < ApplicationController
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
        Classroom.find_or_create(model_data)
      end

      redirect_to classrooms_path, notice: t(:imported_classrooms)
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
end
