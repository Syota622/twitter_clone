# frozen_string_literal: true

class AddProfileFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users, bulk: true do |t|
      t.string :name
      t.string :avatar
      t.string :header_image
      t.text :bio
      t.string :location
      t.string :website
    end
  end
end
