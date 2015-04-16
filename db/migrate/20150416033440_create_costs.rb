class CreateCosts < ActiveRecord::Migration
  def change
    create_table :costs do |c|
      c.string :name
      c.text :description
      c.integer :price
    end
  end
end
