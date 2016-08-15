class TabsController < ApplicationController
  def index
    tabs = Tab.all
    render locals: { tabs: tabs }
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
    tab = Tab.new(tab_params)
    if tab.save
      redirect_to root_path
    else
      flash[:alert] = tab.errors
      render template: 'tabs/new.html.erb', locals: { tab: tab}
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
