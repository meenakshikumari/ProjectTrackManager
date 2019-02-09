class UsersController < ApplicationController
  def index
    if current_user.type == "Manager"
      @developers = Developer.all
      @todos      = Todo.all 
    end
  end
end
