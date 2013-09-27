class CreateVaggas < ActiveRecord::Migration
  def change
    create_table :vaggas do |t|
      t.string :index
      t.integer :book_id

      t.timestamps
    end
  end
end
