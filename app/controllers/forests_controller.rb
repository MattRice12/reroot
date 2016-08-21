class ForestsController < ApplicationController
  def new
    if project = find_proj_param_obj(:project_id)
      if project_permission?(project)
        render locals: { forest: Forest.new }
      else
        flash[:alert] = "You are not authorized to access this project."
        redirect_to projects_path
      end
    else
      flash[:alert] = "This project does not exist."
      redirect_to projects_path
    end
  end

  def create
    if project_permission?(find_proj_by_param_obj_proj(:forest))
      forest = Forest.find_or_create_by(forest_params)
      redirect_to project_path(forest.project)
    else
      flash[:alert] = "You are not authorized to access this project."
      redirect_to projects_path
    end
  end

  def destroy
    forest  = find_forest_params
    if forest.destroy
      redirect(forest.project, FOREST_DESTROYED)
    else
      redirect(:back, forest.errors)
    end
  end

  private

  def forest_params
    params.require(:forest).permit(:project_id, :tree_id)
  end

end
