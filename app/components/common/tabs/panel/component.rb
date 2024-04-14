class Common::Tabs::Panel::Component < ApplicationComponent
  include Common::Tabs::Panel

  option :class_name, Types::String.default(''), optional: true
  option :id, Types::String
end
