class Common::Modal::Component < ApplicationComponent
  option :id, default: -> { SecureRandom.hex(5) }
  option :class_name, Types::String, optional: true
end
