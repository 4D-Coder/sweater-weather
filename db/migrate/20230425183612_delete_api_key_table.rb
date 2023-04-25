class DeleteApiKeyTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :api_keys
    add_column :users, :api_key, :string
  end
end
