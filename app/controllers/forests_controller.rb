class ForestsController < ApplicationController
  def new
    # forests = Forest.where(project_id: params[:project_id])
    # trees = Tree.where(user_id: current_user.id)
    # if (forests - trees ) == forests
    #   render locals: { forests: forests, trees: trees }
    # else
      render locals: { forest: Forest.new }
    # end
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
