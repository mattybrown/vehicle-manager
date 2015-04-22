class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |c|
      c.string :first_name
      c.string :last_name
      c.string :address
      c.string :occupation
      c.string :employer
      c.integer :gst_number
      c.integer :home_phone
      c.integer :mobile_phone
      c.integer :business_phone
      c.string :email
      c.string :bank
      c.date :date_of_birth
      c.string :drivers_license_number
      c.string :nzta_number      

      c.timestamps
    end
  end
end
