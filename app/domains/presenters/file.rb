module Presenters
  class File < Presenter
    IMAGE_TYPES = ['image/jpeg', 'image/png', 'image/gif'].freeze

    expose :url

    def name
      object.file.filename
    end

    def image?
      present? && object.file.content_type.in?(IMAGE_TYPES)
    end

    def present?
      !object.file.nil?
    end
  end
end
