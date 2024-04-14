class Common::Tabs::Component < ApplicationComponent
  include Common::Tabs

  option :class_name, Types::String.default(''), optional: true
  option :tabs_id, default: -> { SecureRandom.hex(10) }, optional: true

  renders_many :buttons, lambda { |id:, disabled: false, class_name: '', is_active: false|
                           Button::Component.new(class_name:, disabled:, id:, is_active:)
                         }

  renders_many :panels, ->(id:, class_name: '') { Panel::Component.new(id:, class_name:) }
end
