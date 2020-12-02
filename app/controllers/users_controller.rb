class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:current_user] = @user

        format.html { redirect_to root_path,
        notice: 'User successfully signed up.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors,
        status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end

end