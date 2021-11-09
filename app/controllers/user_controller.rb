class UserController < ApplicationController
before_action :authenticate_user!, :same_user?

  def show
    @user = User.find(params[:id])
    @events = Event.where(host_id: current_user.id)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(first_name: params[:user_first_name], last_name: params[:user_last_name], description: params[:user_description])
      redirect_to user_path(@current_user.id), success: 'Profil édité !'
    else
      flash[:danger] = "Le profil n'a pas pu être édité !"
      render :edit, status: :unprocessable_entity
      flash.discard
    end
  end

  def destroy
    session.delete(:user_id)
    puts '$' * 80
    puts 'CALLED'
    puts '$' * 80
    redirect_to root_path
  end

  private

  def same_user?
    @user = User.find(params[:id])
    current_user == @user ? nil : (redirect_to root_path)
  end

end
