# frozen_string_literal: true

class EventUser < ApplicationRecord
  belongs_to :event
  belongs_to :user
end
