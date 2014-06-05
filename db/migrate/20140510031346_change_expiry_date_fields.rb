class ChangeExpiryDateFields < ActiveRecord::Migration
  def change
    change_table :vehicles do |v|
      v.change :warrant_expiry, :string
      v.change :vehicle_licence_expiry, :string
    end
  end
end
