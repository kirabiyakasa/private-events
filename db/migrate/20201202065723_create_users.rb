# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.index :username, unique: true

      t.timestamps null: false
    end
  end
end
