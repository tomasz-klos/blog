class Common::Alert::Component < ApplicationComponent
  option :class_name, Types::String, optional: true
  option :type
  option :message
end
