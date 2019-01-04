module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      instance_var = "@#{name}".to_sym
      history_var = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get(instance_var) }
      define_method("#{name}_history") { instance_variable_get(history_var) }
      define_method("#{name}=") do |value|
        if instance_variable_get(history_var).nil?
          instance_variable_set(history_var, [])
        else
          instance_variable_get(history_var).push(instance_variable_get(instance_var))
        end
        instance_variable_set(instance_var, value)
      end
    end
  end

  def strong_attr_accessor(name, type)
    instance_variable_name = "@#{name}"
    define_method(name) { instance_variable_get(instance_variable_name) }
    define_method("#{name}=") do |value|
      raise(TypeError, 'Incorrect class') unless value.is_a?(type)
      instance_variable_set(instance_variable_name, value)
    end
  end
end