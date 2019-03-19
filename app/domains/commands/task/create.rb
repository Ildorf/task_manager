module Commands::Task
  class Create
    def initialize(user_id)
      @task = ::Task.new(user_id: user_id)
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
