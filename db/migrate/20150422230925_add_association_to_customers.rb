class AddAssociationToCustomers < ActiveRecord::Migration
  def change
    change_table :customers do |c|
      c.belongs_to :vehicle, index: true
    end
  end
end
