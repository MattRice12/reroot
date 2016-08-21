class ForestsController < ApplicationController
  def new
    project = find_proj_param_obj(:project_id)
    return proj_validations(project) if !project || !project_permission?(project)
    render locals: { forest: Forest.new }
  end

  def create
    project = find_proj_by_param_obj_proj(:forest)
    return proj_validations(project) if !project || !project_permission?(project)

    Forest.find_or_create_by(forest_params)
    redirect(project, FOREST_CREATED)
  end

  def destroy
    forest = find_forest_params
    return redirect(forest.project, FOREST_DESTROYED) if forest.destroy
    redirect(:back, TREE_NOT_EXIST)
  end

  private

  def forest_params
    params.require(:forest).permit(:project_id, :tree_id)
  end

end
