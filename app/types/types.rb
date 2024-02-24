module Types
  def self.Instance(model_class)
    lambda { |value|
      if value.is_a?(model_class) || value.nil?
        value
      else
        (raise ArgumentError,
               "#{value} is not an instance of #{model_class}")
      end
    }
  end
end
