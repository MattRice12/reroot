class ProjectsController < ApplicationController
  def index
    projects = Project.where(user_id: current_user.id).includes(:members, :users)
    render locals: { projects: projects }
  end

  def show
    project = find_proj_param_obj(:id)
    if project
      if project_permission?(project)
        render locals: { project: project }
      else
        flash[:alert] = "You are not authorized to view this project."
        redirect_to projects_path
      end
    else
      flash[:alert] = "This project does not exist."
      redirect_to projects_path
    end
  end

  def new
    render locals: { project: Project.new }
  end

  def create
    project = Project.new(project_params)
    if project.save
      Member.create!(user_id: current_user.id, project_id: project.id)
      redirect_to projects_path
    else
      flash[:alert] = "Project could not be created"
      render template: 'projects/new.html.erb', locals: { project: project }
    end
  end

  def edit
    render locals: { project: find_proj_param_obj(:id) }
  end

  def update
    project = find_proj_param_obj(:id)
    if project.update(project_params)
      flash[:alert] = "You changed the project name to #{project.name}."
      redirect_to project_path
    else
      render template: 'projects/edit.html.erb', locals: { project: project }
    end
  end

  def captain
    project = find_proj_param_obj(:id)
    project.name = params[:name] if params[:name].present?
    project.user_id = params[:user_id]
    user = project.users.find_by(id: params[:user_id])
    if project.save
      flash[:alert] = "You made #{user.name} the Project Captain."
      redirect_to project_path
    else
      render template: 'projects/edit.html.erb', locals: { project: project }
    end
  end

  def destroy
    project = find_proj_param_obj(:id)
    if project.destroy
      flash[:alert] = "This project disbanded. Thanks, Obama."
      redirect_to projects_path
    else
      flash[:alert] = "This project cannot be deleted"
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :user_id)
  end
end
