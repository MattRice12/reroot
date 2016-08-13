class TreesController < ApplicationController
  def index
    trees = Tree.all
    render locals: { trees: trees }
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
    render locals: {tree: Tree.new}
  end

  def create
    tree = Tree.new(tree_params)
    tab = Tab.new(tab_params)
    if tree.save
      tab.save
      redirect_to tree
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
      redirect_to tree
    else
      render template: 'trees/edit.html.erb', locals: { tree: tree }
    end
  end

  def destroy
    tree = Tree.find(id :params[id])
    if tree.destroy
      render message: "Take that, Greenpeace!"
    else
      render message: "Tree not found."
    end
  end

  private

  def tree_params
    params.require(:tree).permit(:user_id)
  end

  def tab_params
    params.require(:tab).permit(:user_id, :parent_tab_id, :nickname)
  end
end
