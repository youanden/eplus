class ApiAuthorizationsController < ApplicationController
  include QuizletApiHelper

  def create
    auth = QuizletApiHelper.authorization_redirect
    session[:quizlet_state] = auth[:state]
    redirect_to auth[:redirect]
  end

  def authorize
    quizlet_state = params[:state]
    quizlet_code  = params[:code]
    if session[:quizlet_state] == quizlet_state
      QuizletApiHelper.request_token(quizlet_code, current_admin[:id])
      redirect_to root_path, :notice => t(:authorized_api)
    else
      redirect_to root_path, :notice => t(:failed_authorization)
    end
  end
end
