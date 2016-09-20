class ArchivesController < ApplicationController
  def index
    return search_params if params[:search]
    trees = Tree.all.includes(tabs: [:children])
    tabs = Tab.where(parent_tab_id: nil)
    render locals: { trees: trees, tabs: tabs.includes(children: all_the_little_children) }
  end
end
