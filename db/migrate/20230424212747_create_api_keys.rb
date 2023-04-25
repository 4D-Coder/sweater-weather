class CreateApiKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :api_keys do |t|
      t.integer :bearer_id, null: false
      t.integer :bearer_type, null: false
      t.integer :token, null: false

      t.timestamps
    end

    add_index :api_keys, [:bearer_id, :bearer_type]
  end
end
