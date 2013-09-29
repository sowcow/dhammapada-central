class AdIndexesForFriendlyId < ActiveRecord::Migration
  def change
    add_index :books, :index
    add_index :vaggas, :index
    add_index :gathas, :index
  end
end
