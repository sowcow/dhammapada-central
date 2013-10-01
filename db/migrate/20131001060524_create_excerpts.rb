class CreateExcerpts < ActiveRecord::Migration
  def change
    create_table :excerpts do |t|
      t.integer :phrase_id
      t.integer :translation_id
      t.integer :from
      t.integer :to

      t.timestamps
    end
  end
end
