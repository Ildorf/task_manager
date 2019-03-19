class Forms::Task::Save < Forms::Base
  attribute :name,        String
  attribute :description, String
  attribute :attachment,  Types::File

  validates :name, presence: true
end
