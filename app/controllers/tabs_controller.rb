class TabsController < ApplicationController
  def index
    redirect(root_path, "")
  end

  def show
    redirect(root_path, "")
  end

  def new
    tab = Tab.find_by(id: params[:parent_tab_id])
    return render locals: { tab: Tab.new, taboo: tab } if find_tree_params(:tree_id)
    return render locals: { tab: Tab.new, taboo: tab } if find_tab_params(:parent_tab_id)


    # tab = find_tab_params(:parent_tab_id)
    # return redirect(root_path, TAB_NOT_EXIST) if !tab
    # return redirect(root_path, TAB_UNAUTH) if !tab_permission?(tab)
    # render locals: { tab: Tab.new }
  end

  def create
    tab = Tab.new(tab_params)
    tab.user = current_user
    if tab.save
      return redirect(:back, TAB_CREATED)
    end
    flash[:alert] = tree.errors
    render template: 'tabs/new.html.erb', locals: { tab: tab}
  end

  def edit
    tab = find_tab_params(:id)
    return redirect(root_path, TAB_NOT_EXIST) if !tab
    return redirect(root_path, TAB_UNAUTH) if !tab_permission?(tab)
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
    tab_adoption(tab)
    return redirect(root_path, TAB_DESTROYED) if tab.destroy
    render message: TAB_NOT_EXIST
  end

  private

  def tab_params
    params.require(:tab).permit(:tree_id, :user_id, :name, :url, :parent_tab_id)
  end
end
