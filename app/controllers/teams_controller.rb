class TeamsController < ApplicationController
  def show
    @team =  Team.find(params[:id])
    @team_members = @team.users
    @user = User.find(params[:id]) if signed_in?
  end
end
