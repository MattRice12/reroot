class TabsController < ApplicationController
  def index
    redirect(root_path, "")
  end

  def show
    redirect(root_path, "")
  end

  def new
    if tab = find_tab_params(:parent_tab_id)
      tree = tab.tab_root
      render locals: { tab: Tab.new, taboo: tab, tree: tree }
    elsif tree = find_tree_params(:tree_id)
      render locals: { tab: Tab.new, tree: tree }
    end

    # tab = find_tab_params(:parent_tab_id)
    # return redirect(root_path, TAB_NOT_EXIST) if !tab
    # return redirect(root_path, TAB_UNAUTH) if !tab_permission?(tab)
    # render locals: { tab: Tab.new }
  end

  def create
    tab = Tab.new(tab_params)
    tab.user = current_user
    tree = tab.tab_root
    if tab.save
      return redirect(new_tab_path(id: tab.id), TAB_CREATED) if !tab.parent
      return redirect(:back, TAB_CREATED) if tab.parent
    end
    flash[:alert] = tree.errors
    render template: 'tabs/new.html.erb', locals: { tab: tab}
  end

  def edit
    tab = find_tab_params(:id)
    return tab_validations(tab) if !tab || !tab_permission?(tab)
    render locals: { tab: tab }
  end

  def update
    tab = find_tab_params(:id)
    return redirect(tab.tab_root, TAB_UPDATED) if tab.update(tab_params)
    flash[:alert] = tree.errors
    render template: 'tabs/edit.html.erb', locals: { tab: tab }
  end

  def destroy
    tab = find_tab_params(:id)
    if tab.children.any?
      tab_adoption(tab)
      tab.destroy
      return redirect(:back, TAB_DESTROYED)
    else
      tab.destroy
      return redirect(trees_path, TAB_DESTROYED)
    end
    render message: TAB_NOT_EXIST
  end

  private

  def tab_params
    params.require(:tab).permit(:tree_id, :user_id, :name, :url, :parent_tab_id)
  end
end
