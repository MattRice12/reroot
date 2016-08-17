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
    users = User.all
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
      url_after_create
    else
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
      rener message: "User not found."
    end
  end

  def avoid_sign_in
    warn "[DEPRECATION] Clearance's `avoid_sign_in` before_filter is " +
      "deprecated. Use `redirect_signed_in_users` instead. " +
      "Be sure to update any instances of `skip_before_filter :avoid_sign_in`" +
      " or `skip_before_action :avoid_sign_in` as well"
    redirect_signed_in_users
  end

  def redirect_signed_in_users
    if signed_in?
      redirect_to Clearance.configuration.redirect_url
    end
  end

  def url_after_create
    Clearance.configuration.redirect_url
  end

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
    end
  end

  def user_params
    params[Clearance.configuration.user_parameter] || Hash.new
  end
end
