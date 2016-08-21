
class TreesController < ApplicationController
  def index
    return search_params if params[:search]
    trees = Tree.all.includes(tabs: [:children]).order(:created_at)
    render locals: { trees: trees }
  end

  def show
    if tree = find_tree_params
      return render locals: { tree: tree } if tree_permission?
      return redirect(root_path, TREE_UNAUTH)
    end
    return redirect(root_path, TREE_NOT_EXIST)
  end

  def new
    render template: 'trees/new', locals: { tree: Tree.new }
  end

  def create
    tree = Tree.new(tree_params)
    return redirect(root_path, TREE_CREATED) if tree.save
    flash[:alert] = tree.errors
    render template: 'trees/new', locals: { tree: tree}
  end

  def new_forest
    if project = find_proj_param_obj(:project_id)
      return render template: 'trees/new_forest', locals: { tree: Tree.new } if project_permission?(project)
      return redirect(projects_path, PROJ_UNAUTH)
    end
    return redirect(projects_path, PROJ_NOT_EXIST)
  end

  def create_forest
    project = find_proj_by_param_obj_proj(:tree)
    tree = Tree.new(forest_tree_params)
    if tree.save
      forest = Forest.new(forest_params)
      forest.tree_id = tree.id
      return redirect(project, FOREST_CREATED) if forest.save
      return redirect(root_path, forest.errors)
    end
    flash[:alert] = tree.errors
    render template: 'trees/new_forest', locals: { tree: tree }
  end

  def edit
    if params[:project_id]
      project = find_proj_param_obj(:project_id)
      return redirect(projects_path, PROJ_NOT_EXIST) if !project
      return redirect(projects_path, PROJ_UNAUTH) if !project_permission?(project)
    end
    tree = find_tree_params
    return redirect(trees_path, TREE_NOT_EXIST) if !tree
    return redirect(trees_path, TREE_UNAUTH) if !tree_permission?
    return render locals: { tree: tree }
  end

  def update
    tree = find_tree_params
    project = find_proj_by_param_obj_proj(:tree)
    if tree.update(tree_params)
      return redirect(project, TREE_UPDATED) if project
      return redirect(tree, TREE_UPDATED) if !project
    end
    flash[:alert] = tree.errors
    render template: 'trees/edit.html.erb', locals: { tree: tree }
  end

  def destroy
    tree = find_tree_params
    return redirect(root_path, TREE_DESTROYED) if tree.destroy
    return render message: TREE_NOT_EXIST
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
