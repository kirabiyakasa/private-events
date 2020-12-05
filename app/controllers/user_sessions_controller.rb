class UserSessionsController < ApplicationController

  def destroy
    session.delete(:current_user)
    redirect_to events_path
  end

  def new
  end

  def create

    respond_to do |format|
      if @user_session = User.find_by(username: params[:session][:username])
        session[:current_user] = @user_session

        format.html { redirect_to root_path,
        notice: 'User successfully signed in.' }
      else
        format.html { render :new }
        format.json { render json: @user.errors,
        status: :unprocessable_entity }
      end
    end
  end

end
