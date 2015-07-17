require_relative "../../config/environment"
require_relative "../models/list"
require_relative "../models/task"
require_relative "../models/user"

require "pry"
class ApplicationController < Sinatra::Base
@client_id = "7a68574922e8934a3270"
@access_token = "4bc602fedc5f6af2727e4acf61368a9000e267ca91ac3cdef4c07ee047b1"
@client_secret = "00be30b9cb01e2befdaa28f463a5d65b179a699744b25bdbd3c0aa157237"
 
  # You must create API CLIENT at first.
	wl = Wunderlist::API.new({
		:access_token => @access_token,
		:client_id => @client_id})
	
	use OmniAuth::Builder do
		provider :wunderlist, "7a68574922e8934a3270" , "00be30b9cb01e2befdaa28f463a5d65b179a699744b25bdbd3c0aa157237"
	end

  configure do
    set :public_folder, "public"
    set :views, "app/views"
    set :sessions, true
    set :session_secret, "todo"
  end
  
#   get '/auth/wunderlist/callback' do
#   	auth = request.env['omniauth.auth']
#   	@user = User.find_or_create_by(wunderlist_user_id: auth[:uid])
#   	@user.update(:name => auth[:info][:name], :wunderlist_user_id => auth[:uid])
#   	session[:user_id] = @user.id
#   	redirect "/"
#   end
  
  get "/" do
# 	  wl.lists.each do |list|
# 		newInst = List.find_or_create_by(:name => list.title, :done? => false, :wunderlist_id => list.id)	
#  			list.tasks.each do |task|
# 				Task.find_or_create_by(:name => task.title, :list_id =>newInst.id, :done? => false)
# 				
# 			end
# 	end
	
# 	  @user = current_user
	  @lists = List.all
	  puts @lists
	  @comlists = List.where(:done? => true).all
	  @incomlists = List.where(:done? => false).all
# 	  @name = @user.name
	  erb :index
	  
  end
  
  post "/" do
	if params[:name] != ""
	  List.create(:name => params[:listname], :done? => false)
	  redirect "/"
	end
	redirect "/"
  end
  
  get "/lists/:id" do
	  @list = List.find(params[:id])
	  @tasks = @list.tasks
	  @completed = @tasks.where(:done? => true).all
  	  @incompleted = @tasks.where(:done? => false).all
 
	  erb :list
  end
   
  post "/lists/:id/create_task" do
	if params[:name] != ""
	  Task.create(:name => params[:name], :list_id => params[:id], :done? => false)
	  redirect "/lists/#{params[:id]}"
	end
	  redirect "/lists/#{params[:id]}"
  end
 
  get '/lists/:id/highfive' do
  	@list = List.find(params[:id])
  	@tasks = @list.tasks
  	@completed = @tasks.where(:done? => true).all
  	@incompleted = @tasks.where(:done? => false).all
# 	puts @tasks
	
	if @incompleted.empty?
		@list.update(:done? => true)  
	end	
  	erb :highfive
  end
  
  post '/lists/:id' do
	@list = List.find(params[:id])
	@tasks = @list.tasks
	@completed = @tasks.where(:done? => true).all
  	@incompleted = @tasks.where(:done? => false).all
	
	

  		if params[:done] != nil
			params[:done].each do |item|
				@task = Task.find(item)
				@task.update(:done? => true)
				@completed.each do |up|
					wl.list(@list.name).tasks.each do |this|
						if this.title == up.name
							this.completed = true
						end
						end
						end
				redirect "/lists/#{params[:id]}/highfive"
			end
		else
			redirect "/lists/#{params[:id]}/highfive"
		end
  	
  end
  
  get '/lists/:id/delete' do
  	@list = List.find(params[:id])
  	@list.destroy
  	redirect "/"
  end
  
  get '/lists/:id/delete_task' do
  	@task = Task.find(params[:id])
  	@task.destroy
  	redirect "/lists/#{@task.list_id}"
  end

def current_user
	User.find(session[:user_id])
end

end  


  #methods
  
#   def finished?(id)
# 	@list = List.find(id)
#   	@tasks = @list.tasks
#   	@completed = @tasks.where(:done? => true).all
#   	@incompleted = @tasks.where(:done? => false).all





