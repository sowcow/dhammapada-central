class AddMeaningIdToExcerpts < ActiveRecord::Migration
  def change
    add_column :excerpts, :meaning_id, :integer
  end
end
