class MembersController < ApplicationController

  def new
    render locals: { member: Member.new }
  end

  def create
    member = Member.find_or_create_by(member_params)
    redirect_to team_path(member.team)
  end

  def destroy
    if current_user.id == team.user_id
      member = Member.find(params[:id])
      member.destroy
      redirect_to team_path(member.team)
    else
      flash[:alert] = "Only the team leader can delete members."
      redirect_to team_path(member.team)
    end
  end

  private

  def member_params
    params.require(:member).permit(:user_id, :team_id)
  end
end
