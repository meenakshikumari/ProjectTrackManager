class TodosController < ApplicationController

  before_action :load_user
  before_action :load_project, except: [:developer_stats, :project_stats]

  before_action :load_todo,    only: [:show, :update, :destroy]
  before_action :load_developers, only: [:new, :edit]

  def index
    if @current_user.type == "Manager"
      @todos = @project.todos
    else
      @todos = @current_user.assigned_todos.where(project_id: @project.id)
    end
  end

  def edit
    @todo = Todo.find params[:id]
  end

  def update
    if @todo.update_attributes(todo_params)
      @todo.update_attributes(developer_ids: params[:todo][:developer_ids].reject(&:empty?)) if params[:todo][:developer_ids]
      flash[:success] = "project updated successfully" 
      redirect_to user_project_todos_path
    else
      render :edit and return
    end
  end

  def new
    @todo = @project.todos.build
  end

  def create
    @todo = @project.todos.build todo_params
    @todo.developer_ids = params[:todo][:developer_ids].reject(&:empty?) if params[:todo][:developer_ids]
    if @todo.save
      flash[:success] = "project created successfully" 
      redirect_to user_project_todos_path
    else
      render :new and return
    end
  end

  def developer_stats
    @assigned_developers = Todo.includes(:developers).collect{|t| t.developers.pluck(:name)}.flatten.uniq.sort
    status_arr = %w(New InProgress Done)
    @stats = {}

    status_arr.each do |status|
      dev = {}
      @assigned_developers.each do |developer|
        dev[developer] = Developer.where(name: developer).first.assigned_todos.where(status: status).pluck(:name)
        end
      @stats[status] = dev
    end
  end

  def project_stats
    @project_names = Project.where(id: Todo.pluck(:project_id).uniq).pluck(:name)
    status_arr = %w(New InProgress Done)
    @stats = {}

    status_arr.each do |status|
      project = {}
      @project_names.each do |p|
        project[p] = Project.where(name: p).first.todos.where(status: status).pluck(:name)
      end
      @stats[status] = project
    end
    p @stats
  end

  private

  def load_user
    @current_user = User.find params[:user_id]
  end

  def load_project
    @project = Project.find params[:project_id]
  end

  def load_todo
    @todo = Todo.find params[:id]
  end

  def load_developers
    @developers = @project.developers
  end

  def todo_params
    params.require(:todo).permit(:name, :description, :status)
  end
end
