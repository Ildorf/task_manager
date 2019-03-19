module Presenters
  class Task < Presenter
    expose :id
    expose :name
    expose :description
    expose :state

    has_one :attachment, presenter: Presenters::File

    def user
      object.user.email
    end

    def created_at
      object.created_at.localtime.strftime('%m/%d/%Y %H:%M')
    end

    def state_events
      StateMachines::Task.new(object).events
    end

    def with_attachment?
      !object.attachment.file.nil?
    end
  end
end
