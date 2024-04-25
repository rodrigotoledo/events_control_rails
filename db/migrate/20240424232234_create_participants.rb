class CreateParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :participants do |t|
      t.string :name
      t.string :email
      t.string :uid

      t.timestamps
    end
  end
end
