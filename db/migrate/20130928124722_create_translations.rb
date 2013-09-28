class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.integer :source_id
      t.references :translateable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
