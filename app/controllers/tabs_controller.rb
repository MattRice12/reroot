class TabsController < ApplicationController
  def index
    if params[:search]
      search_params
    else
      tabs = Tab.all
      render locals: { tabs: tabs }
    end
  end

  def show
    tab = Tab.find(params.fetch(:id))
    if tab
      render locals: { tab: tab }
    else
      redirect_to tabs
    end
  end

  def new
    render locals: {tab: Tab.new}
  end

  def create
    if current_user.nil?
      redirect_to sign_in_path
    else
      tab = Tab.new(tab_params)
      tab.user = current_user
      if tab.save
        redirect_to root_path
      else
        flash[:alert] = "The tab could not be created"
        render template: 'tabs/new.html.erb', locals: { tab: tab}
      end
    end
  end

  def edit
    render locals: { tab: Tab.find(params.fetch(:id)) }
  end

  def update
    tab = Tab.find(params.fetch(:id))
    if tab.update(tab_params)
      redirect_to root_path
    else
      render template: 'tabs/edit.html.erb', locals: { tab: tab }
    end
  end

  def destroy
    tab = Tab.find(params.fetch(:id))

    if tab.parent
      tabchild = Tab.where(parent_tab_id: params.fetch(:id))
      tabchild.each do |tc|
        tc.parent_tab_id = tab.parent.id
        tc.save
      end
    end

    if tab.destroy
      flash[:alert] = "Take that, Greenpeace!"
      redirect_to root_path
    else
      render message: "Tab not found."
    end
  end

  private

  def tab_params
    params.require(:tab).permit(:tree_id, :user_id, :name, :url, :parent_tab_id)
  end
end
