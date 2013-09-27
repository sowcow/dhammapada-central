class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :index

      t.timestamps
    end
  end
end
