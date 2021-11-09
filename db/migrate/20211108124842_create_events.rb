# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.datetime :start_date
      t.integer :duration
      t.string :title
      t.text :description
      t.integer :price
      t.string :location
      t.timestamps
      t.belongs_to :host, class_name: 'User', index: true
    end
  end
end
