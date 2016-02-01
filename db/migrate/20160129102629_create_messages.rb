class CreateMessages < ActiveRecord::Migration
  def change

    create_table :messages do |t|
      t.integer :parent_id
      t.integer :sender_id
      t.text :message
      t.timestamps
    end
  end
end
