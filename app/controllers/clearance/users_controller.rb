class Clearance::UsersController < Clearance::BaseController
  if respond_to?(:before_action)
    before_action :redirect_signed_in_users, only: [:create, :new]
    skip_before_action :require_login, only: [:create, :new], raise: false
    skip_before_action :authorize, only: [:create, :new], raise: false
  else
    before_filter :redirect_signed_in_users, only: [:create, :new]
    skip_before_filter :require_login, only: [:create, :new], raise: false
    skip_before_filter :authorize, only: [:create, :new], raise: false
  end

  def index
    users = User.all.order(:name)
    render template: 'users/index.html.erb', locals: { users: users }
  end

  def show
    user = User.find(params.fetch(:id))
    if user
      render template: 'users/show.html.erb', locals: { user: user }
    else
      redirect_to users
    end
  end

  def new
    if signed_in?
      redirect_to "/users"
    else
      @user = User.new
      render template: "users/new.html.erb"
    end
  end

  def create
    @user = User.new(custom_user_params)
    if @user.save
      sign_in @user
      redirect_to root_path
    else
      render template: "users/new.html.erb"
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
    render template: "users/edit.html.erb"
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(custom_user_params)
      redirect_to @user
      flash[:alert] = "User Account Updated"
    else
      render template: 'users/edit.html.erb'
    end
  end

  def destroy
    user = User.find_by(id: params.fetch(:id))
    if user.destroy
      render message: "User deleted."
      redirect_to users_path
    else
      render message: "User not found."
    end
  end

  private

  def custom_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def redirect_signed_in_users
    if signed_in?
      redirect_to "/users"
    end
  end

  def url_after_create
    redirect_to "/users"
  end

  def user_from_params
    name = user_params.delete(:name)
    email = user_params.delete(:email)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.name = name
      user.email = email
      user.password = password
    end
  end

  def user_params
    params[Clearance.configuration.user_parameter] || Hash.new
  end
end
