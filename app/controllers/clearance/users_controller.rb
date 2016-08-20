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
      @user = user_from_params
      render template: "users/new.html.erb"
    end
  end

  def create
    @user = user_from_params
    if @user.save
      sign_in @user
      redirect_to root_path
    else
      flash[:alert] = "Errors: Unable to create Account."
      render template: "users/new.html.erb"
    end
  end

  def edit
    render locals: { user: User.find(params.fetch(:id)) }
  end

  def update
    @user = user_from_params
    if @user.save
      redirect_to user
    else
      render template: 'user/edit.html.erb', locals: { user: user }
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
