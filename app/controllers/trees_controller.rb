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
    project = Project.find_by(id: params[:project_id])
    render locals: { tree: Tree.new, project: project}
  end

  def create
    tree = Tree.create!(tree_params)
    if tree.save
      forest = Forest.new(forest_params)
      forest.tree_id = tree.id
      if forest.save
        redirect_to root_path
      else
        redirect_to root_path
      end
    else
      flash[:alert] = tree.errors
      render template: 'trees/new.html.erb', locals: { tree: tree}
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

  def forest_params
    params.require(:tree).permit(:project_id)
  end
end
