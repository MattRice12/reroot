class ProjectsController < ApplicationController
  def index
    projects = Project.all
    render locals: { projects: projects }
  end

  def show
    project = Project.find(params[:id])
    if project
      render locals: { project: project }
    else
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
    render locals: { project: Project.find(params.fetch(:id)) }
  end

  def update
    project = Project.find(params.fetch(:id))
    if project.update(project_params)
      flash[:alert] = "You changed the project name to #{project.name}."
      redirect_to project_path
    else
      render template: 'projects/edit.html.erb', locals: { project: project }
    end
  end

  def captain
    project = Project.find(params.fetch(:id))
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
    project = Project.find(params.fetch(:id))
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
