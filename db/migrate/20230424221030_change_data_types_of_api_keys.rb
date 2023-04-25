class ChangeDataTypesOfApiKeys < ActiveRecord::Migration[7.0]
  def change
    change_column :api_keys, :bearer_type, :string
    change_column :api_keys, :token, :string
  end
end
