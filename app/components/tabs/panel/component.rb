class Tabs::Panel::Component < ApplicationComponent
  include Tabs::Panel

  option :class_name, optional: true
  option :id, Types::String
end
