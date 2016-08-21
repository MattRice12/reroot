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
    tree = Tree.find_by(id: params[:id])
    [
      current_user.id == tree.user_id,
      current_user.projects.any? { |proj| proj.trees.any? { |tr| tr.id } } == params[:id]
    ].any?
  end







  def find_proj_param_obj(obj)
    Project.find_by(id: params[obj])
  end

  def find_proj_by_param_obj_proj(obj)
    Project.find_by(id: params[obj][:project_id])
  end

  def project_permission?(obj)
    project = obj
    project.members.any? { |m| m.user_id == current_user.id }
  end


end
