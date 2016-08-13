class UsersController < ApplicationController
  def index
    users = User.all
    render locals: { users: users }
  end

  def show
    user = User.find(params.fetch(:id))
    if user
      render locals: { user: user }
    else
      redirect_to users
    end
  end

  def new
    render locals: { user: User.new }
  end

  def create
    user = User.new(users_params)
    if user.save
      redirect_to user
    else
      flash[:alert] = user.errors
      render template: 'users/new.html.erb', locals: { user: user }
    end
  end

  def edit
    render locals: { user: User.find(params.fetch(:id)) }
  end

  def update
    user = User.find(params.fetch(:id))
    if user.update(user_params)
      redirect_to user
    else
      render template: 'user/new.html.erb', locals: { user: user }
    end
  end

  def destroy
    user = User.find_by(id: params.fetch(:id))
    if user.destroy
      render message: "User deleted."
    else
      rener message: "User not found."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
