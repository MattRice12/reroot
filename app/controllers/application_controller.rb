class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def search_params
    trees = Tree.all.includes(tabs: [:children]).order(:id)
    tabs = Tab.search(params[:search])
    users = User.search(params[:search]).order(:name)
    render template: 'trees/index.html.erb', locals: { trees: trees, tabs: tabs, users: users }
  end
end
