class Task < ApplicationRecord
  enum state: %i[new started finished], _prefix: :state

  belongs_to :user

  scope :sorted, -> { order(:id) }
  scope :with_user, -> { includes(:user) }
  scope :all_with_user, -> { all.with_user.sorted }
  scope :of_user, ->(user_id) { where(user_id: user_id).sorted }

  mount_uploader :attachment, ::AttachmentUploader
end
