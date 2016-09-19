class ArchivesController < ApplicationController
  def index
    return search_params if params[:search]
    trees = Tree.all.includes(tabs: [:children])
    tabs = Tab.where(parent_tab_id: nil)
    render locals: { trees: trees, tabs: tabs.includes(children: all_the_little_children) }
  end

  def show
    return search_params if params[:search]
    tree = find_tree_params(:id)
    tabs = Tab.where(parent_tab_id: nil)
    return tree_validations(tree) if !tree || !tree_permission?(tree)
    render locals: { tree: tree, tabs: tabs }
  end
end
