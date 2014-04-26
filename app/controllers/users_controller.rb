# Controller for users
class UsersController < ApplicationController
  def edit
    user = User.find params[:id]
    @edit_form = EditUserForm.new user
  end

  def update
    user = User.find params[:id]
    @edit_form = EditUserForm.new user
    if @edit_form.validate_and_save params[:user]
      user.update_with_password(user_params)
      user.update_attributes(user_params)
      sign_in(user, bypass: true)
      flash[:success] = 'Updated profile!'
      redirect_to after_sign_in_path_for(user)
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.required(:user).permit!
  end
end
