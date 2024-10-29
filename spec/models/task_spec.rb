# frozen_string_literal: true

# spec/models/task_spec.rb
require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:user) { create(:user) }

  # Association test
  it { is_expected.to belong_to(:user) }

  # Validation tests
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:due_date) }
  it { is_expected.to validate_presence_of(:category) }

  # Enum tests
  describe 'enums' do
    it 'defines categories correctly' do
      expect(described_class.categories).to eq({
                                                 'Work' => 'Work',
                                                 'Personal' => 'Personal',
                                                 'Shopping' => 'Shopping',
                                                 'Private' => 'Private',
                                                 'Public' => 'Public',
                                                 'General' => 'General',
                                                 'Important' => 'Important',
                                                 'Other' => 'Other'
                                               })
    end

    it 'defines priorities correctly' do
      expect(described_class.priorities).to eq({ 'low' => 0, 'medium' => 1, 'high' => 2 })
    end
  end
end
