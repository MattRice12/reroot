module ProjectsHelper
  def user_trees
    current_user.trees
  end

  def project_trees
    Project.find(params[:id]).trees
  end

  def contributions(user)
    # binding.pry

    forests = Forest.where(project_id: params[:id])

    trees = Tree.where(id: forests.map { |forest| forest.tree_id })
    tab = Tab.where(tree_id: trees.each { |tree| tree.id }).where(user_id: user.id)
    return tab
  end
end
