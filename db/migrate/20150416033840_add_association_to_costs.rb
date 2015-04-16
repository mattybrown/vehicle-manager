class AddAssociationToCosts < ActiveRecord::Migration
  def change
    change_table :costs do |c|
      c.belongs_to :vehicle, index: true
    end
  end
end
