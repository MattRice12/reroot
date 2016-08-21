
class TreesController < ApplicationController
  def index
    if params[:search]
      search_params
    else
      trees = Tree.all.includes(tabs: [:children]).order(:created_at)
      render locals: { trees: trees }
    end
  end

  def show
    tree = Tree.find(params.fetch(:id))
    if tree
      render locals: { tree: tree }
    else
      redirect_to trees
    end
  end

  def new
    render template: 'trees/new', locals: { tree: Tree.new }
  end

  def create
    tree = Tree.create!(tree_params)
    if tree.save
      redirect_to root_path
    else
      flash[:alert] = tree.errors
      render template: 'trees/new.html.erb', locals: { tree: tree}
    end
  end

  def new_forest
    render template: 'trees/new_forest', locals: { tree: Tree.new }
  end

  def create_forest
    project = Project.find_by(id: params[:tree][:project_id])
    if project_permission?
      tree = Tree.new(forest_tree_params)
      if tree.save
        forest = Forest.new(forest_params)
        forest.tree_id = tree.id
        if forest.save
          redirect_to project
        else
          flash[:alert] = tree.errors
          redirect_to :back
        end
      else
        flash[:alert] = tree.errors
        redirect_to :back
      end
    else
      flash[:alert] = "You must be invited to a project before you can add trees to it."
      redirect_to projects_path
    end
  end

  def edit
    render locals: { tree: Tree.find(params.fetch(:id)) }
  end

  def update
    tree = Tree.find(params.fetch(:id))
    if tree.update(tree_params)
      redirect_to tree_path
    else
      render template: 'trees/edit.html.erb', locals: { tree: tree }
    end
  end

  def destroy
    tree = Tree.find_by(id: params.fetch(:id))
    if tree.destroy
      flash[:alert] = "Take that, Greenpeace!"
      redirect_to :back
    else
      render message: "Tree not found."
    end
  end

  private

  def tree_params
    params.require(:tree).permit(:user_id, :name)
  end

  def forest_tree_params
    params.require(:tree).permit(:user_id, :name)
  end

  def forest_params
    params.require(:tree).permit(:project_id)
  end
end
