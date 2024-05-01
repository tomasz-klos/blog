class Common::Tabs::Panel::Component < ApplicationComponent
  include Common::Tabs::Panel

  option :class_name, optional: true
  option :id, Types::String
end
