class TabsController < ApplicationController
  def index
    redirect(root_path, "")
  end

  def show
    redirect(root_path, "")
  end

  def new
    if tab = find_tab_params(:parent_tab_id) ## if there is a root tab
      tree = nil
      render locals: { tab: Tab.new, taboo: tab, tree: tree }
    elsif tree = find_tree_params(:tree_id) ## if there is no root tab
      # tab = tree.tab.tab_root
      render locals: { tab: Tab.new, tree: tree }
    end
  end

  def create
    tab = Tab.new(tab_params)
    tab.user = current_user
    tree = tab.tab_root
    tab2 = Tab.find_by(parent_tab_id: params[:parent_tab_id])
    if tab.save
      if tab == tab2
        return redirect(new_tab_path(parent_tab_id: tab.parent_tab_id), TAB_CREATED)
      else
        return redirect(:back, TAB_CREATED) if tab.parent
      end
    end
    flash[:alert] = tree.errors
    render template: 'tabs/new.html.erb', locals: { tab: tab }
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
    tree = tab.tab_root
    tab_adoption(tab)
    tab2 = Tab.where(parent_tab_id: params[:parent_tab_id])
    if tab2.any? { |t| t != tab }
      tab.destroy
      return redirect(:back, TAB_DESTROYED)
    else
      tab.destroy
      return redirect(root_path, TAB_DESTROYED)
    end
    render message: TAB_NOT_EXIST
  end

  private

  def tab_params
    params.require(:tab).permit(:tree_id, :user_id, :name, :url, :parent_tab_id)
  end
end
