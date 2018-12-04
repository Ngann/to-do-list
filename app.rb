require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/task")
require("./lib/list")
require("pg")

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
  @lists = List.all()
  erb(:success)
 end

 get("/full_list") do
   @list_words = List.all()
   erb(:output)
 end

 get('/list-list') do
   @lists = List.all()
   erb(:list)
 end

 get("/lists/:id") do
  @list = List.find(params.fetch("id").to_i())
  erb(:list)
end

post("/tasks") do
  description = params.fetch("description")
  list_id = params.fetch("list_id").to_i()
  @list = List.find(list_id)
  @task = Task.new({:description => description, :list_id => list_id})
  @task.save()
  erb(:task_success)
end
