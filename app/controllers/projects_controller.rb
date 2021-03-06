class ProjectsController < ApplicationController
  def index
    return search_params if params[:search]
    projects = Project.where(user_id: current_user.id).includes(:members, :users)
    render locals: { projects: projects }
  end

  def show
    return search_params if params[:search]
    project = find_proj_param_obj(:id)
    tabs = Tab.where(parent_tab_id: nil)
    return proj_validations(project) if !project || !project_permission?(project)
    render locals: { project: project, tabs: tabs }
    # render locals: { project: project, tabs: tabs.includes(children: [children: [children: [children: [children: [children: [children: [children: [children: [children: [children: [children: [children: [children: [children: [children: [:children]]]]]]]]]]]]]]]]) }
  end

  def new
    render locals: { project: Project.new }
  end

  def create
    project = Project.new(project_params)
    if project.save
      Member.create!(user_id: current_user.id, project_id: project.id)
      redirect(project, PROJECT_CREATED)
    else
      flash[:alert] = "Project could not be created"
      render template: 'projects/new.html.erb', locals: { project: project }
    end
  end

  def edit
    project = find_proj_param_obj(:id)
    return proj_validations(project) if !project || !project_permission?(project)
    render locals: { project: project }
  end

  def update
    project = find_proj_param_obj(:id)
    return proj_validations(project) if !project || !project_permission?(project)
    return redirect(project, PROJECT_UPDATED) if project.update(project_params)
    render template: 'projects/edit.html.erb', locals: { project: project }
  end

  def captain
    project = find_proj_param_obj(:id)
    return proj_validations(project) if !project || !project_permission?(project)
    project.user_id = params[:user_id]
    return redirect(project, "You made #{project.user.name} the Project Captain.") if project.save
    render template: 'projects/edit.html.erb', locals: { project: project }
  end

  def destroy
    project = find_proj_param_obj(:id)
    return proj_validations(project) if !project || !project_permission?(project)
    return redirect(projects_path, PROJECT_DESTROYED) if project.destroy
    redirect(project, NOT_DELETE)
  end

  private

  def project_params
    params.require(:project).permit(:name, :user_id)
  end
end
