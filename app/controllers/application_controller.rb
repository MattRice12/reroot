class ApplicationController < ActionController::Base
  before_action :require_login

  include Clearance::Controller
  protect_from_forgery with: :exception

  def search_params
    tabs = Tab.search(params[:search])
    users = User.search(params[:search]).order(:name)
    render template: 'trees/search.html.erb', locals: { tabs: tabs, users: users }
  end
end
