class ChangeVehicle < ActiveRecord::Migration
  def change
    change_table :vehicles do |v|
      v.boolean :security_interest
      v.boolean :radio_receiver
      v.boolean :re_registered_vehicle
      v.boolean :road_user_charges
      v.boolean :outstanding_road_user_charges
      v.boolean :imported
      v.boolean :imported_damaged
      v.integer :warrant_expiry
      v.integer :vehicle_licence_expiry
      v.integer :first_registered
      v.integer :first_registered_overseas
      v.string :country_last_registered
      v.string :registration_number
      v.string :vin_number
      v.string :fuel_type
      v.rename :engine, :engine_capacity
      v.rename :kilometers, :kilometers_travelled
      
    end
  end
end
