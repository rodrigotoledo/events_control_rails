# frozen_string_literal: true

class CreateParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :participants do |t|
      t.string :name
      t.string :email
      t.string :uid
      t.string :phone
      t.string :password_digest

      t.timestamps
    end
  end
end
