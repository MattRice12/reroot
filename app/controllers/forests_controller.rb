class ForestsController < ApplicationController
  def new
    render locals: { forest: Forest.new }
  end

  def create
    forest = Forest.find_or_create_by(forest_params)
    redirect_to project_path(forest.project)
  end

  def destroy
    forest  = Forest.find(params[:id])
    project = forest.project
    if forest.destroy
      flash[:alert] = "This forest was as ancient as time... and you destroyed it..."
      redirect_to project
    else
      flash[:alert] = "The fairies protect this forest. You fail to destroy it."
    end
  end

  private

  def forest_params
    params.require(:forest).permit(:project_id, :tree_id)
  end

end
