class MembersController < ApplicationController

  def new
    render locals: { member: Member.new }
  end

  def create
    member = Member.find_or_create_by(member_params)
    redirect_to project_path(member.project)
  end

  def destroy
    project = Project.find(params[:id])
    member = project.members.find_by(user_id: current_user.id)
    if member.destroy
      flash[:alert] = "You left the project"
      member = project.members.first
      project.user_id = member.user_id
      project.save
      redirect_to projects_path
    else
      flash[:alert] = "You cannot leave"
    end
  end

  private

  def member_params
    params.require(:member).permit(:user_id, :project_id)
  end
end
