# frozen_string_literal: true

# spec/features/tasks_spec.rb
require 'rails_helper'

RSpec.describe 'Tasks', type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:task) { FactoryBot.create(:task, user: user) }
  let!(:pending_task) { FactoryBot.create(:task, user: user, completed: false) }
  let!(:completed_task) { FactoryBot.create(:task, user: user, completed: true) }

  before do
    sign_in user
  end

  describe 'GET /tasks' do
    it 'displays the task index' do
      visit tasks_path
      expect(page).to have_content('Tasks')
    end
  end

  describe 'Creating a Task' do
    it 'creates a new task' do
      visit new_task_path
      fill_in 'Title', with: 'New Task'
      fill_in 'Description', with: 'Task Description'
      select 'Work', from: 'Category'
      click_button 'Create Task'

      expect(page).to have_content('Task created successfully.')
      expect(page).to have_content('New Task')
    end
  end

  describe 'Updating a Task' do
    before { task }

    it 'updates the task' do
      visit edit_task_path(task)
      fill_in 'Title', with: 'Updated Task'
      click_button 'Update Task'

      expect(page).to have_content('Task updated successfully.')
      expect(page).to have_content('Updated Task')
    end
  end

  describe 'GET /tasks/pending' do
    it 'returns a success response' do
      visit pending_tasks_path
      expect(page.status_code).to eq(200) # Check for a successful response
    end

    it 'assigns only pending tasks to @tasks' do
      visit pending_tasks_path
      expect(page).to have_content(pending_task.title) # Ensure the pending task is displayed
      expect(page).not_to have_content(completed_task.title) # Ensure the completed task is not displayed
    end
  end

  describe 'GET /tasks/completed' do
    it 'returns a success response' do
      visit completed_tasks_path
      expect(page.status_code).to eq(200) # Check for a successful response
    end

    it 'assigns only completed tasks to @tasks' do
      visit completed_tasks_path
      expect(page).to have_content(completed_task.title) # Ensure the completed task is displayed
      expect(page).not_to have_content(pending_task.title) # Ensure the pending task is not displayed
    end
  end
end
