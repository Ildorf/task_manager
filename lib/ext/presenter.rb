class Presenter
  class << self
    def map(records)
      records.map do |record|
        new(record)
      end
    end

    def expose(attribute_name)
      attr_reader(attribute_name)
      attributes.push(attribute_name)
    end

    def has_one(association_name, presenter:)
      attr_reader(association_name)
      associations[association_name] = { presenter: presenter, type: :has_one }
    end

    def has_many(association_name, presenter:)
      attr_reader(association_name)
      associations[association_name] = { presenter: presenter, type: :has_many }
    end

    def attributes
      @attributes ||= []
    end

    def associations
      @associations ||= {}
    end
  end

  private_class_method :expose, :has_one, :has_many

  def initialize(object)
    @object = object
    self.class.attributes.each do |attribute_name|
      expose_attribute(attribute_name)
    end
    self.class.associations.each_key do |key|
      expose_association(key, self.class.associations[key])
    end
  end

  private

  def expose_association(association_name, options)
    associated_object = object&.public_send(association_name)
    var_value = if options[:type] == :has_many
                  associated_object ? options[:presenter].map(associated_object) : []
                else
                  associated_object ? options[:presenter].new(associated_object) : nil
                end
    instance_variable_set("@#{association_name}", var_value)
  end

  def expose_attribute(attribute_name)
    value = @object.public_send(attribute_name)
    instance_variable_set("@#{attribute_name}", value)
  end

  attr_reader :object
end
