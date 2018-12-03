class Task
  attr_reader(:description, :list_id, :duedate)

  def initialize(attributes)
    @description = attributes.fetch(:description)
    @list_id = attributes.fetch(:list_id)
    @duedate = attributes.fetch(:duedate)
  end

  def self.all
    returned_tasks = DB.exec("SELECT * FROM tasks;")
    tasks = []
    returned_tasks.each() do |task|
      description = task.fetch("description")
      list_id = task.fetch("list_id").to_i()
      duedate = task.fetch("duedate")
      tasks.push(Task.new({:description => description, :list_id => list_id, :duedate => duedate}))
    end
    tasks
  end

  def ==(another_task)
    self.description().==(another_task.description()).&(self.list_id().==(another_task.list_id()))
  end

  def save
     DB.exec("INSERT INTO tasks (description, list_id, duedate) VALUES ('#{@description}', #{@list_id},  #{@duedate});")
   end

 def order_by
   order = DB.exec("SELECT * FROM tasks ORDER BY duedate;")
 end

end
