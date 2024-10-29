# frozen_string_literal: true

# Model representing a task in the system with managing.
class Task < ApplicationRecord
  belongs_to :user

  enum :category, {
    Work: 'Work',
    Personal: 'Personal',
    Shopping: 'Shopping',
    Private: 'Private',
    Public: 'Public',
    General: 'General',
    Important: 'Important',
    Other: 'Other'
  }
  enum :priority, { low: 0, medium: 1, high: 2 }

  validates :title, presence: true
  validates :description, presence: true
  validates :due_date, presence: true
  validates :category, presence: true

  default_scope { order(id: :desc) }
  scope :public_or_general, -> { where(category: %w[Public General]) }
  scope :filter_by_category, ->(category) { where(category: category) if category.present? }
  scope :filter_by_completed, ->(completed) { where(completed: completed) if completed.present? }
  scope :filter_by_due_date, ->(due_date) { where(due_date: ..due_date) if due_date.present? }
  scope :filter_by_title, ->(title) { where('title ILIKE ?', "%#{title}%") }
end
