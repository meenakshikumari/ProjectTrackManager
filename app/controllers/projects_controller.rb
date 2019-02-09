class ProjectsController < ApplicationController

  # load_and_authorize_resource :user

  before_action :load_user
  before_action :load_project,    only: [:show, :update, :destroy]
  before_action :load_developers, only: [:new, :edit]

  def index
    @projects = @current_user.type == "Manager" ? @current_user.projects : @current_user.assigned_projects
  end

  def edit
    @project = Project.find params[:id]
  end

  def update
    if @project.update_attributes(project_params)
      @project.update_attributes(developer_ids: params[:project][:developer_ids].reject(&:empty?)) if params[:project][:developer_ids]
      flash[:success] = "project updated successfully" 
      redirect_to user_projects_path
    else
      render :edit and return
    end
  end

  def new
    @project = @current_user.projects.build
  end

  def create
    @project = @current_user.projects.build project_params
    @project.developer_ids = params[:project][:developer_ids].reject(&:empty?) if params[:project][:developer_ids]
    if @project.save
      flash[:success] = "project created successfully" 
      redirect_to user_projects_path
    else
      render :new and return
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to user_projects_path
  end

  private

  def load_developers
    @developers = Developer.all
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end

  def load_project
    @project = Project.find params[:id]
  end

  def load_user
    @current_user = User.find params[:user_id]
  end
end
