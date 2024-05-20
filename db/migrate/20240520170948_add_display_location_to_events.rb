# frozen_string_literal: true

class AddDisplayLocationToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :display_location, :boolean, default: false
  end
end
