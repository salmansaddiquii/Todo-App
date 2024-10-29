# frozen_string_literal: true

# Homes controller
class HomesController < ApplicationController
  def index
    @tasks = Task.public_or_general
  end
end
