class AddHostelToEvents < ActiveRecord::Migration[7.1]
  def change
    add_reference :events, :hostel, null: false, foreign_key: true
  end
end
