# frozen_string_literal: true

# spec/factories/tasks.rb
FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "Sample Task #{n}" }
    description { 'Task description' }
    due_date { Date.tomorrow }
    category { 'Work' }
    priority { :medium }
    completed { false }
    association :user
  end
end
