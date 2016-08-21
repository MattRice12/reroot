class MembersController < ApplicationController

  def new
    project = find_proj_param_obj(:project_id)
    return redirect(projects_path, PROJ_NOT_EXIST) if !project
    return redirect(projects_path, PROJ_UNAUTH) if !project_permission?(project)
    return render locals: { member: Member.new } if project
  end

  def create
    member = Member.find_or_create_by(member_params)
    redirect(project_path(member.project), "#{member.user.name.capitalize} has been added to the project!")
  end

  def boot
    member  = Member.find(params[:id])
    project = member.project
    return redirect(project, "#{member.user.name.capitalize} has been booted!") if member.destroy
    flash[:alert] = "You cannot leave."
  end

  def leave
    project = find_proj_param_obj(:id)
    member = project.members.find_by(user_id: current_user.id)
    if member.destroy
      if project.members.any?
        member = project.members.first
        project.user_id = member.user_id
        project.save
      end
      return redirect(projects_path, "You left the project.")
    end
    return redirect(project, "You cannot leave.")
  end

  private

  def member_params
    params.require(:member).permit(:user_id, :project_id)
  end
end
