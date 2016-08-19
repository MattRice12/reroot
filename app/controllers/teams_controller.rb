class TeamsController < ApplicationController
  def index
    teams = Team.all
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
      flash[:alert] = "You changed the team name to #{team.name}."
      redirect_to team_path
    else
      render template: 'teams/edit.html.erb', locals: { team: team }
    end
  end

  def captain
    team = Team.find(params.fetch(:id))
    team.name = params[:name] if params[:name].present?
    team.user_id = params[:user_id]
    user = team.users.find_by(id: params[:user_id])
    if team.save
      flash[:alert] = "You made #{user.name} the Team Captain."
      redirect_to team_path
    else
      render template: 'teams/edit.html.erb', locals: { team: team }
    end
  end

  def destroy
    team = Team.find(params.fetch(:id))
    if team.destroy
      flash[:alert] = "This team disbanded. Thanks, Obama."
      redirect_to teams_path
    else
      flash[:alert] = "This team cannot be deleted"
    end
  end

  private

  def team_params
    params.require(:team).permit(:name, :user_id)
  end
end
