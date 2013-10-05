class CreateMeanings < ActiveRecord::Migration
  def change
    create_table :meanings do |t|
      t.references :translateable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
