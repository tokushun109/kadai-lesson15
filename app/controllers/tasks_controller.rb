class TasksController < ApplicationController
    before_action :set_task,only:[:show, :edit ,:update, :destroy]
    before_action :require_user_logged_in
    before_action :correct_user, only: [:update, :destroy]
    
    def index
        @tasks = Task.where(user_id: current_user.id)
    end

    def show
    end

    def new
        @task = Task.new
    end

    def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクを追加しました。'
      redirect_to user_path(current_user)
    else
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'タスクの追加に失敗しました。'
      render :show
    end
  end

    def edit
    end

    def update
        if @task.update(task_params)
            flash[:success] = "タスクを編集しました"
            redirect_to task_path(@task)
        else
            flash.now[:danger] = "タスクの編集に失敗しました"
            render :edit
        end
    end

    def destroy
        @task.destroy
        
        flash[:success] = 'タスクを削除しました'
        redirect_to root_url
    end
    
    private
    def task_params
        params.require(:task).permit(:content,:status)
    end
    
    def set_task
        @task = Task.find(params[:id])
    end

    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
        redirect_to root_url
        end
    end
end


