require 'sinatra'
require 'data_mapper'
require './models'

get '/' do
  @slots = Slot.all(:order => [:grade.asc])
  erb :list
end
  
get '/signup/:id' do
  @slot = Slot.get(params[:id])
  erb :signup
end
  
post '/signup' do
  @appointment = Appointment.create(
    student: params[:appointment][:student], 
    parent: params[:appointment][:parent],
    email: params[:appointment][:email],
    grade: params[:appointment][:grade],
    homeroom: params[:appointment][:homeroom],
    slot_id: params[:appointment][:slot_id])
  erb :confirmation
end