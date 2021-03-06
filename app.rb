require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/task")
require("./lib/list")
require("pg")
require('pry')

DB = PG.connect({:dbname => "to_do"})

get("/") do
  @list_names = List.all()
  erb(:input)
end

get("/lists/new") do
  @list_names = List.all()
  erb(:list_form)
end

post("/lists") do
  @name = params.fetch("name")
  list = List.new({:name => @name, :id => nil})
  list.save()
  @list_names = List.all()
  erb(:success)
 end

 get("/full_list") do
   @list_names = List.all()
   erb(:output)
 end

 get("/lists/:id") do
  list_id = params.fetch("id").to_i()
  @list = List.find(list_id)
  erb(:list_detail)
end

get("/task_form") do
 erb(:task_form)
end

post("/tasks") do
  @list_names = List.all()
  description = params.fetch("description")
  duedate = params.fetch("duedate").to_i()
  list_id = params.fetch("list_id").to_i()
  @list = List.find(list_id)
  @task = Task.new({:description => description, :list_id => list_id, :duedate => duedate,})
  @task.save()
  erb(:task_success)
end

get("/tasks") do
  @list_names = List.all()
end
