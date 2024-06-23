class Tabs::Button::Component < ApplicationComponent
  include Tabs::Button

  option :id, Types::String
  option :class_name, optional: true
  option :disabled, default: false, optional: true
  option :is_active, default: false, optional: true
end
