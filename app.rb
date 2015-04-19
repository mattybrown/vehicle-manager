require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'
require 'rack-flash'
require 'bundler/setup'

set :database, "sqlite:///vms.db"
enable :sessions
set :session_secret, 'very very secret'
use Rack::Flash


class Vehicle < ActiveRecord::Base
  validates :make, presence: true
  validates :model, presence: true
  validates :year, presence: true
  validates :buyprice, presence: true
  validates :stock_number, presence: true
end

class User < ActiveRecord::Base
  validates :uname, presence: true
  validates :password, presence: true
end

class Cost < ActiveRecord::Base
  validates :price, numericality: true
end

helpers do
  def create_password(p)
    BCrypt::Password.create(p)
  end

  def logged_in?
    session['u']
  end

  def calculate_profit(v)
    vehicle = Vehicle.find(v)
    costs = Cost.where(vehicle_id: v)
    total_cost = 0
    costs.each do |c|
      if c.price != nil
        total_cost += c.price
      end
    end

    profit = vehicle.sellprice - vehicle.buyprice - total_cost
    return profit.round(2)
  end

  def days_in_stock(v)
    vehicle = Vehicle.find(v)
    pd = vehicle.purchase_date
    if vehicle.sale_date == "" or vehicle.sale_date == nil
      pd = Date.parse(pd)
      today = Date.today
      return today.mjd - pd.mjd
    else
      sd = Date.parse(vehicle.sale_date)
      pd = Date.parse(pd)
      return sd.mjd - pd.mjd
    end
  end

  def true_yes(t)
    if t == true
      return "Yes"
    else
      return "No"
    end
  end

end

get "/" do
  @vehicles = Vehicle.find(:all, :order => "stock_number DESC")
  @flash = flash[:notice]
  @user = session['a']
  erb :"vehicles/index"
end

post "/vehicles" do
  @vehicle = Vehicle.new(params[:vehicle])
=begin
  if params[:vehicle][:main_picture]
    File.open('public/cars/' + params[:vehicle][:main_picture][:filename], "w") do |f|
      f.write(params[:vehicle][:main_picture][:tempfile].read)
    end

    @vehicle.main_picture = params[:vehicle][:main_picture][:filename]
  end
=end  
  @vehicle.sellprice = params[:vehicle][:sellprice].delete "$,"
  @vehicle.buyprice = params[:vehicle][:buyprice].delete "$,"
  @vehicle.kilometers_travelled = params[:vehicle][:kilometers_travelled].delete ","

  if @vehicle.save
    flash[:notice] = "Vehicle saved"
    redirect "/"
  else
    flash[:notice] = "Save failed - #{params[:vehicle]}"
    redirect "/"
    
  end
end

post "/vehicles/edit/:id" do
  @vehicle = Vehicle.find(params[:id])
  @vehicle.update(params[:vehicle])
  @vehicle.sellprice = params[:vehicle][:sellprice].delete "$,"
  @vehicle.buyprice = params[:vehicle][:buyprice].delete "$,"
  @vehicle.kilometers_travelled = params[:vehicle][:kilometers_travelled].delete ","

  if @vehicle.save
    flash[:notice] = "Vehicle updated"
    redirect "/"
  else
    flash[:notice] = @vehicle.errors.messages
    redirect "/"
    
  end
end

get '/vehicles/edit/:id' do
  @vehicle = Vehicle.find(params[:id])
  erb :"vehicles/edit"
end

get '/vehicles/show/:id' do
  @vehicle = Vehicle.find(params[:id])
  @costs = Cost.where(vehicle_id: params[:id])
  @flash = flash[:notice]
  erb :"vehicles/show"
end

get "/vehicles/new" do
  @vehicle = Vehicle.new
  erb :"vehicles/new"
end

get "/vehicles/delete/:id" do
  Vehicle.destroy(params[:id])
  flash[:notice] = "Car removed"
  redirect "/"
end

post "/costs" do
  @cost = Cost.new(params[:cost])
  if @cost.save
    flash[:notice] = "Cost added"
    redirect back

  else
    flash[:notice] = @cost.errors.full_messages
    redirect back
    
  end
end

get "/costs/delete/:id" do
  Cost.destroy(params[:id])
  flash[:notice] = "Cost deleted"
  redirect back
end

get "/users/new" do
  @user = User.new
  erb :"users/new"
end

post "/users" do
  @user = User.new(params[:user])
  @user.password = create_password(params[:user][:password])
  if @user.save
    redirect "/"
  else
    flash[:notice] = "Nah didn't work!"
  end
end

post "/login" do
  if user = User.find_by_uname(params[:user][:uname])
    if BCrypt::Password.new(user.password) == params[:user][:password]
      session['u'] = true
      session['a'] = user.uname
      redirect "/"
    else
      flash[:notice] = "Incorrect password"
      redirect "/"
    end
  else
    flash[:notice] = "No such user"
    redirect "/"
  end
end

get "/logout" do
  session['u'] = false
  redirect "/"
end
