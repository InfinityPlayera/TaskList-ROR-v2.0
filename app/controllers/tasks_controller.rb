class TasksController < ApplicationController
    def index
        @tasks = Task.all
        @task = Task.new
        @done_tasks = Task.where(completed: true).order(:position)
        @doing_tasks = Task.where(completed: false).order(:position)
    end

    def edit
        @task = Task.find(params[:id])
    end

    def update
        @task = Task.find(params[:id])
        @task.update(completed: params[:completed])

        render json: { message: "Success" }
    end

    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        redirect_to tasks_path, notice: "Task was successfully deleted."
    end

    def create
        @task = Task.new(task_params)

        respond_to do |format|
            if @task.save
                format.html { redirect_to tasks_url, notice: "Task was successfully created." }
            else
                format.html { render :new, status: :unproccessable_entity }
            end
        end
    end

    private

    def task_params
        params.require(:task).permit(:name)
    end
end
