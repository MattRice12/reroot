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

  def new
    render locals: { team: Team.new }
  end

  def create
    team = Team.new(team_params)
    if team.save
      Member.create!(user_id: current_user.id, team_id: team.id)
      redirect_to teams_path
    else
      flash[:alert] = "Team could not be created"
      render template: 'teams/new.html.erb', locals: { team: team }
    end
  end

  def edit
    render locals: { team: Team.find(params.fetch(:id)) }
  end

  def update
    team = Team.find(params.fetch(:id))
    if team.update(team_params)
      redirect_to root_path
    else
      render template: 'teams/edit.html.erb', locals: { team: team }
    end
  end

  def destroy
    team = Team.find(params.fetch(:id))

    if team.parent
      teamchild = Team.where(parent_team_id: params.fetch(:id))
      teamchild.each do |tc|
        tc.parent_team_id = team.parent.id
        tc.save
      end
    end

    if team.destroy
      flash[:alert] = "Take that, Greenpeace!"
      redirect_to root_path
    else
      render message: "Team not found."
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :user_id)
  end
end
