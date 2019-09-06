require "sinatra"

require "sinatra/activerecord"

require_relative "./lib/record.rb"
require_relative "./lib/reminder.rb"
require_relative "./lib/user.rb"
require "pry"

class Server < Sinatra::Base
    get "/" do
        erb :index, locals: {user: User.all.first}, layout: :layout
    end

    post "/users/:user_id/reminders" do |user_id|
        Reminder.create(user_id: user_id, time_of_day: params["morning"])
        Reminder.create(user_id: user_id, time_of_day: params["afternoon"])
        Reminder.create(user_id: user_id, time_of_day: params["evening"])
        erb :index, locals: {user: User.all.first}, layout: :layout
    end

    post "/users/:user_id/medicalRecords" do |user_id|
        
        Record.create(user_id: user_id, sugar_levels: params["sugar_levels"].to_f, date: Time.now.to_s)
        erb :index, locals: {user: User.all.first}, layout: :layout
    end

    post "/users" do
        User.create(params)
        erb :index, locals: {user: User.all.first}, layout: :layout
    end

    get "/records" do 
        erb :record, locals: {records: Record.all }, layout: :layout
    end

    get "/empty-app" do
        User.delete_all
        Reminder.delete_all
        Record.delete_all
    end

    get '/reminders/:name' do |name|
        user = Users.find_by(name: name)
        tasks = user.map { |user| user.reminders }
        latest_notification = Notification.all.last
        erb :reminders_list, locals: { array: richards, tasks: tasks, notifcation: latest_notification }
    end
end