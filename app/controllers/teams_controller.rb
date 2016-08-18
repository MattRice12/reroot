class TeamsController < ApplicationController
  def index
    teams = Team.all.includes(:users)
    render locals: { teams: teams }
  end

  def show
    team = Team.find(params[:id])
    if team
      render locals: { team: team }
    else
      redirect_to teams_path
    end
  end
end
