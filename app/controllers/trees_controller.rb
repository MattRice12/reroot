class TreesController < ApplicationController
  def index
    return search_params if params[:search]
    trees = Tree.all.includes(tabs: [:children])
    tabs = Tab.where(parent_tab_id: nil)
    render locals: { trees: trees, tabs: tabs.includes(children: all_the_little_children) }

    ### Practicing replacing AR with SQL --- eager loading not working ###
    # trees = Tree.find_by_sql(
    #   """
    #   SELECT * FROM trees
    #   """)
    #
    # tabs = Tab.find_by_sql(
    #   """
    #   SELECT a.*
    #   FROM tabs a
    #   JOIN trees
    #   ON trees.id = a.tree_id
    #   WHERE a.parent_tab_id IS NULL;
    #   """
    #   )
    # render locals: { trees: trees, tabs: tabs }
  end

  def show
    return search_params if params[:search]
    tree = find_tree_params(:id)
    tabs = Tab.where(parent_tab_id: nil)
    return tree_validations(tree) if !tree || !tree_permission?(tree)
    render locals: { tree: tree, tabs: tabs }
  end

  def new
    render template: 'trees/new', locals: { tree: Tree.new }
  end

  def create
    tree = Tree.new(tree_params)
    return redirect(root_path, TREE_CREATED) if tree.save
    render template: 'trees/new', locals: { tree: tree}
  end

  def new_forest
    project = find_proj_param_obj(:project_id)
    return proj_validations(project) if !project || !project_permission?(project)
    render template: 'trees/new_forest', locals: { tree: Tree.new } if project_permission?(project)
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
    render template: 'trees/new_forest', locals: { tree: tree }
  end

  def edit
    tree = find_tree_params(:id)
    if params[:project_id]
      project = find_proj_param_obj(:project_id)
      return proj_validations(project) if !project || !project_permission?(project)
    else
      return tree_validations(tree) if !tree || !tree_permission?(tree)
    end
    render locals: { tree: tree }
  end

  def update
    tree = find_tree_params(:id)
    project = find_proj_by_param_obj_proj(:tree)
    return redirect(project, TREE_UPDATED) if project && tree.update(tree_params)
    return redirect(tree, TREE_UPDATED) if !project && tree.update(tree_params)
    flash[:alert] = tree.errors
    render template: 'trees/edit.html.erb', locals: { tree: tree }
  end

  def destroy
    tree = find_tree_params(:id)
    return redirect(root_path, TREE_DESTROYED) if tree.destroy
    render message: TREE_NOT_EXIST
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
