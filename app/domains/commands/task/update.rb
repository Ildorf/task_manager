module Commands::Task
  class Update
    def initialize(task)
      @task = task
    end

    def perform(attributes)
      task.assign_attributes(attributes)
      task.save!
      task
    end

    private

    attr_reader :task
  end
end
