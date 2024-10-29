# frozen_string_literal: true

# Abstract base class for models, providing application-wide model methods.
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
