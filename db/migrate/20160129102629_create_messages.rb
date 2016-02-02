class CreateMessages < ActiveRecord::Migration
  def change

    create_table :messages do |t|
      t.references :parent, index: true
      t.references :sender, index: true
      t.text :message
      t.timestamps
    end
  end
end
