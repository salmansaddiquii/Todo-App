# frozen_string_literal: true

# Tasks controller
class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[edit update destroy complete show]

  def index
    @tasks = current_user.tasks
                         .filter_by_title(params[:title])
                         .filter_by_category(params[:category])
                         .filter_by_completed(params[:completed])
                         .filter_by_due_date(params[:due_date])
  end

  def show; end

  def new
    @task = current_user.tasks.new
  end

  def edit; end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: t('notices.task_created')
    else
      render turbo_stream: turbo_stream.replace('task_form', partial: 'form', locals: { task: @task })
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('notices.task_updated')
    else
      render turbo_stream: turbo_stream.replace('task_form', partial: 'form', locals: { task: @task })
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('notices.task_destroy')
  end

  def complete
    @task.update(completed: true)
    redirect_to tasks_path, notice: t('notices.task_completed')
  end

  def pending
    @tasks = current_user.tasks.where(completed: false)
  end

  def completed
    @tasks = current_user.tasks.where(completed: true)
  end

  private

  def set_task
    @task = current_user.tasks.find_by(id: params[:id])
    redirect_to tasks_path, notice: t('notices.unauthorize_task') unless @task
  end

  def task_params
    params.require(:task).permit(:title, :description, :due_date, :completed, :category, :priority)
  end
end
