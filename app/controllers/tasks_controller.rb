class TasksController < ApplicationController
    before_action :set_task,only:[:show, :edit ,:update, :destroy]
    
    def index
        @tasks = Task.all.page(params[:page])
    end

    def show
    end

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)
        if @task.save
            flash[:success] = "正常にタスクを追加できました"
            redirect_to task_path(@task)
        else
            flash.now[:danger] = "タスクの保存に失敗しました"
                render :new
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
        redirect_to tasks_url
    end
    
    private
    def task_params
        params.require(:task).permit(:content,:status)
    end
    
    def set_task
        @task = Task.find(params[:id])
    end

end
