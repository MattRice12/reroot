module ProjectsHelper
  def user_trees
    current_user.trees
  end

  def project_trees
    Project.find(params[:id]).trees
  end
end
