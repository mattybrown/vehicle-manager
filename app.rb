require 'sinatra'
require 'sinatra/activerecord'
require 'bcrypt'
require 'rack-flash'
require 'bundler/setup'

set :database, "sqlite:///vms.db"
enable :sessions
use Rack::Flash


class Vehicle < ActiveRecord::Base
  validates :make, presence: true
  validates :model, presence: true
  validates :year, presence: true
  validates :buyprice, presence: true
end

class User < ActiveRecord::Base
  validates :uname, presence: true
  validates :password, presence: true
end

helpers do
  def create_password(p)
    BCrypt::Password.create(p)
  end

  def logged_in?
    session['u']
  end
end

get "/" do
  @vehicles = Vehicle.all
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
    redirect "/"
  else
    flash[:notice] = "Save failed - #{params[:vehicle]}"
    redirect "/"
    
  end
end

get '/vehicles/edit/:id' do
  @vehicle = Vehicle.find(params[:id])
  erb :"vehicles/edit"
end

get '/vehicles/show/:id' do
  @vehicle = Vehicle.find(params[:id])
  erb :"vehicles/show"
end

get "/vehicles/new" do
  @vehicle = Vehicle.new
  erb :"vehicles/new"
end

get "/vehicles/delete/:id" do
  Vehicle.destroy(params[:id])
  redirect "/"
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
