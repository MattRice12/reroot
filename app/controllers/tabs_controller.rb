class TabsController < ApplicationController
  def index
    return search_params.includes(:trees) if params[:search]
    tabs = Tab.all.includes(:trees)
    render locals: { tabs: tabs }
  end

  def show
    tab = find_by_tab_params(:id)
    if tab
      render locals: { tab: tab }
    else
      redirect(tabs_path, TAB_NOT_EXIST)
    end
  end

  def new
    if find_tree_params(:tree_id)
      if tree_permission?(tree)
        render locals: { tab: Tab.new }
      else
        redirect(root_path, TREE_UNAUTH)
      end
    else
      redirect(root_path, TREE_NOT_EXIST)
    end
  end


  def create
    tab = Tab.new(tab_params)
    tab.user = current_user
    if tab.save
      redirect(tab.tab_root, TAB_CREATED)
    else
      flash[:alert] = tree.errors
      render template: 'tabs/new.html.erb', locals: { tab: tab}
    end
  end

  def edit
    render locals: { tab: find_tab_params(:id) }
  end

  def update
    tab = find_tab_params(:id)
    if tab.update(tab_params)
      redirect_to tab.tab_root
    else
      flash[:alert] = tree.errors
      render template: 'tabs/edit.html.erb', locals: { tab: tab }
    end
  end

  def destroy
    tab = find_by_tab_params(:id)

    if tab.parent
      tabchild = where_tab_params
      tabchild.each do |tc|
        tc.parent_tab_id = tab.parent.id
        tc.save
      end
    end

    if tab.destroy
      flash[:alert] = "Take that, Greenpeace!"
      redirect_to root_path
    else
      render message: TREE_NOT_EXIST
    end
  end

  private

  def tab_params
    params.require(:tab).permit(:tree_id, :user_id, :name, :url, :parent_tab_id)
  end
end
