class SessionsController < ApplicationController
  def new
    if current_admin
      redirect_to root_url, :notice => t(:signed_in_message)
    end
  end

  def create
    admin = Admin.authenticate(params[:username], params[:password])
    if admin
      session[:admin_id] = admin.id
      redirect_to root_url, :notice => t(:signed_in_message)
    else
      flash.now.alert = t(:invalid_email_or_password)
      render "new"
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to root_url, :notice => t(:signed_out_message)
  end
end
