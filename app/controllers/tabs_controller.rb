class TabsController < ApplicationController
  def index
    redirect(root_path, "")
  end

  def show
    redirect(root_path, "")
  end

  def new
    return render locals: { tab: Tab.new } if find_tree_params(:tree_id)
    return render locals: { tab: Tab.new } if find_tab_params(:parent_tab_id)


    # tab = find_tab_params(:parent_tab_id)
    # return redirect(root_path, TAB_NOT_EXIST) if !tab
    # return redirect(root_path, TAB_UNAUTH) if !tab_permission?(tab)
    # render locals: { tab: Tab.new }
  end

  def create
    tab = Tab.new(tab_params)
    tab.user = current_user
    return redirect(tab.tab_root, TAB_CREATED) if tab.save
    flash[:alert] = tree.errors
    render template: 'tabs/new.html.erb', locals: { tab: tab}
  end

  def edit
    tab = find_tab_params(:id)
    return redirect(root_path, TAB_NOT_EXIST) if !tab
    return redirect(root_path, TAB_UNAUTH) if !tab_permissions?(tab)
    render locals: { tab: tab }
  end

  def update
    tab = find_tab_params(:parent_tab_id)
    return redirect_to tab.tab_root if tab.update(tab_params)
    flash[:alert] = tree.errors
    render template: 'tabs/edit.html.erb', locals: { tab: tab }
  end

  def destroy
    tab = find_tab_params(:id)

    if tab.parent
      tabchild = Tab.where(parent_tab_id: tab.parent.id)
      tabchild.each do |tc|
        tc.parent_tab_id = tab.parent.parent_tab_id
        tc.save
      end
    end

    if tab.destroy
      return redirect(root_path, TAB_DESTROYED)
    end
    render message: TREE_NOT_EXIST
  end

  private

  def tab_params
    params.require(:tab).permit(:tree_id, :user_id, :name, :url, :parent_tab_id)
  end
end
