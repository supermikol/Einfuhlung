class AddHiddenToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :hidden, :boolean, null: false, default: false
  end
end
