class Admin::ProjectsController < Admin::ApplicationController

  before_action :set_project, only: [:destroy]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: "Project has been created."
    else
      flash.now[:alert] = "Project has not been created"
      render "new"
    end
  end

  def destroy
    @project.destroy

    flash[:notice] = "Project has been deleted"
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def set_project
    @project = Project.find(params[:id])

    rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'The project you were looking for could not be found'
    redirect_to projects_path
  end

end
