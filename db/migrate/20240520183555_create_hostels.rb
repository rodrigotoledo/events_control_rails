class CreateHostels < ActiveRecord::Migration[7.1]
  def change
    create_table :hostels do |t|
      t.string :name
      t.string :address
      t.string :slogan
      t.text :description
      t.string :phone

      t.timestamps
    end
  end
end
