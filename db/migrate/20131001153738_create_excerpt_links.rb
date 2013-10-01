class CreateExcerptLinks < ActiveRecord::Migration
  def change
    create_table :excerpt_links do |t|
      t.integer :one_id
      t.integer :two_id

      t.timestamps
    end
  end
end
