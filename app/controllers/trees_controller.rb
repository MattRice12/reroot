
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
    if tree = find_tree_params
      if tree_permission?
        render locals: { tree: tree }
      else
        redirect(root_path, TREE_UNAUTH)
      end
    else
      redirect(root_path, TREE_NOT_EXIST)
    end
  end

  def new
    render template: 'trees/new', locals: { tree: Tree.new }
  end

  def create
    tree = Tree.new(tree_params)
    if tree.save
      redirect(root_path, TREE_CREATED)
    else
      flash[:alert] = tree.errors
      render template: 'trees/new', locals: { tree: tree}
    end
  end

  def new_forest
    if project = find_proj_param_obj(:project_id)
      if project_permission?(project)
        render template: 'trees/new_forest', locals: { tree: Tree.new }
      else
        redirect(projects_path, PROJ_UNAUTH)
      end
    else
      redirect(projects_path, PROJ_NOT_EXIST)
    end
  end

  def create_forest
    project = find_proj_by_param_obj_proj(:tree)
    tree = Tree.new(forest_tree_params)
    if tree.save
      forest = Forest.new(forest_params)
      forest.tree_id = tree.id
      if forest.save
        redirect(project, FOREST_CREATED)
      else
        redirect(root_path, forest.errors)
      end
    else
      flash[:alert] = tree.errors
      render template: 'trees/new_forest', locals: { tree: tree }
    end
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
    if tree.update(tree_params)
      if project = find_proj_by_param_obj_proj(:tree)
        redirect(project, TREE_UPDATED)
      else
        redirect(tree, TREE_UPDATED)
      end
    else
      flash[:alert] = tree.errors
      render template: 'trees/edit.html.erb', locals: { tree: tree }
    end
  end

  def destroy
    tree = find_tree_params
    tree.destroy
    if params[:id]
      redirect(root_path, TREE_DESTROYED)
    else
      redirect(:back)
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
