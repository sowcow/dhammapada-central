class AddTextToTranslation < ActiveRecord::Migration
  def change
    add_column :translations, :text, :text
  end
end
