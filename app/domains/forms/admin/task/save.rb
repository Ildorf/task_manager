class Forms::Admin::Task::Save < Forms::Base
  attribute :user_id,     Integer
  attribute :name,        String
  attribute :description, String
  attribute :attachment,  Types::File

  validates :name, presence: true
  validates :user_id, presence: true

  def user_id_options
    User.mapped_emails
  end
end
