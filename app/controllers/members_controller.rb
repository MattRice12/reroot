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
    member.destroy
    redirect_to team_path(member.team)
  end

  private

  def member_params
    params.require(:member).permit(:user_id, :team_id)
  end
end
