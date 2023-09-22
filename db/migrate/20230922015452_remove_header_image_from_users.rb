class RemoveHeaderImageFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :header_image, :string
  end
end
