class AddProfileFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :avatar, :string
    add_column :users, :header_image, :string
    add_column :users, :bio, :text
    add_column :users, :location, :string
    add_column :users, :website, :string
  end
end
