class CreateGathas < ActiveRecord::Migration
  def change
    create_table :gathas do |t|
      t.string :index
      t.integer :vagga_id

      t.timestamps
    end
  end
end
