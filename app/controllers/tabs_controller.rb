class TabsController < ApplicationController
  def index
    redirect(root_path, "")
  end

  def show
    redirect(root_path, "")
  end

  def new
    if params[:search]
      return search_params
    elsif tab = find_tab_params(:parent_tab_id) ## if there is a root tab
      tree = nil
      render locals: { tab: Tab.new, taboo: tab, tree: tree }
    elsif tree = find_tree_params(:tree_id) ## if there is no root tab
      render locals: { tab: Tab.new, tree: tree }
    end
  end

  def create
    tab = Tab.new(tab_params)
    tab.user = current_user
    tree = tab.tab_root
    if tab.save
      if !tab.parent_tab_id
        return redirect(new_tab_path(parent_tab_id: tab.id), TAB_CREATED)
      else
        return redirect(:back, TAB_CREATED)
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
    tab_adoption(tab)
    tree_adoption(tab)
    tab2 = Tab.where(id: params[:parent_tab_id])
    # tab2 = Tab.where(parent_tab_id: params[:parent_tab_id]) && Tab.where(id: params[:parent_tab_id])
            #=> Not sure why I needed the first part
    if tab.destroy
      if tab2.any? { |t| t != tab } #targets non-root tabs in the mini-tree
        return redirect(:back, TAB_DESTROYED)
      elsif project = params[:project] #for when current_user is on the projects page
        return redirect(project, TAB_DESTROYED)
      else 
        return redirect(root_path, TAB_DESTROYED)
      end
    end
    return render message: TAB_NOT_EXIST
  end

  private

  def tab_params
    params.require(:tab).permit(:tree_id, :user_id, :name, :url, :parent_tab_id)
  end
end
