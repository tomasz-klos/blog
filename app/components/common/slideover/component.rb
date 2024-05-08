class Common::Slideover::Component < ApplicationComponent
  include Common::Slideover

  option :class_name, Types::String, optional: true

  renders_one :trigger, lambda { |variant: :primary, id: '', class_name: ''|
                          Trigger::Component.new(id:, class_name:, variant:)
                        }
end
