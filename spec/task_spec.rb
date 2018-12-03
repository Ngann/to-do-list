require("spec_helper")

describe(Task) do
  describe(".all") do
    it("is empty at first") do
      expect(Task.all()).to(eq([]))
    end
  end

  describe("#save") do
    it("adds a task to the array of saved tasks") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1, :duedate => 5})
      test_task.save()
      expect(Task.all()).to(eq([test_task]))
    end
  end

  describe("#description") do
    it("lets you read the description out") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1, :duedate => 5})
      expect(test_task.description()).to(eq("learn SQL"))
    end
  end

  describe("#list_id") do
    it("lets you read the list ID out") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1, :duedate => 5})
      expect(test_task.list_id()).to(eq(1))
    end
  end

  describe("#duedate") do
    it("lets you read the duedate out") do
      test_task = Task.new({:description => "learn SQL", :list_id => 1, :duedate => 5})
      expect(test_task.duedate()).to(eq(5))
    end
  end

  describe("#==") do
    it("is the same task if it has the same description and list ID") do
      task1 = Task.new({:description => "learn SQL", :list_id => 1, :duedate => 5})
      task2 = Task.new({:description => "learn SQL", :list_id => 1, :duedate => 5})
      expect(task1).to(eq(task2))
    end
  end

  describe("#order_by") do
    it("orders tasks by duedate") do
      test_task = Task.new({:description => "Learn SQL", :list_id => 1, :duedate => "5"})
      test_task.save()
      test_task2 = Task.new({:description => "Review Ruby", :list_id => 1, :duedate => "6"})
      test_task2.save()
      test_task3 = Task.new({:description => "Review Ruby", :list_id => 1, :duedate => "10"})
      test_task3.save()
      expect(Task.all()).to(eq([test_task, test_task2, test_task3]))
    end
  end

end
