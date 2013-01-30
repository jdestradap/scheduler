class ExpandUserFields < ActiveRecord::Migration
  def change
    add_column :users, :role_type, :string
    add_column :users, :role_id, :integer
  end
end