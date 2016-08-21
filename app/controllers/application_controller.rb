class ApplicationController < ActionController::Base
  before_action :require_login

  include Clearance::Controller
  protect_from_forgery with: :exception

  def search_params
    tabs = Tab.search(params[:search])
    users = User.search(params[:search]).order("LOWER(name)")
    render template: 'trees/search.html.erb', locals: { tabs: tabs, users: users }
  end

  def tab_permission?
    current_user.id == tab.tab_root.id
  end

  def tree_permission?
    tree = Tree.find(params[:id])
    [
      current_user.id == tree.user_id,
      current_user.projects.any? { |proj| proj.trees.any? { |tr| tr.id } } == params[:id]
    ].any?
  end

  def project_permission?
    project = Project.find_by(id: params[:tree][:project_id])
    project.members.any? { |m| m.user_id == current_user.id }
  end
end
