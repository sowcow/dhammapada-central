class AddLangToSources < ActiveRecord::Migration
  def change
    add_column :sources, :lang, :string
  end
end
