# frozen_string_literal: true

class Api::ApplicationController < ActionController::API
  include AuthenticationConcern
end
