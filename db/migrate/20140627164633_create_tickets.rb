class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :description
      t.boolean :status, default: false

      t.timestamps
    end
  end
end
