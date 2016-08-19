class MembersController < ApplicationController

  def new
    render locals: { member: Member.new }
  end

  def create
    member = Member.find_or_create_by(member_params)
    redirect_to team_path(member.team)
  end

  def destroy
    team = Team.find(params[:id])
    member = team.members.find_by(user_id: current_user.id)
    if member.destroy
      flash[:alert] = "You left the team"
      member = team.members.first
      team.user_id = member.user_id
      team.save
      redirect_to teams_path
    else
      flash[:alert] = "You cannot leave"
    end
  end

  private

  def member_params
    params.require(:member).permit(:user_id, :team_id)
  end
end
