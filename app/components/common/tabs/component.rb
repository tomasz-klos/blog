class Common::Tabs::Component < ApplicationComponent
  include Common::Tabs
  option :tabs_id, default: -> { SecureRandom.hex(10) }, optional: true

  renders_many :buttons, lambda { |id:, disabled: false, class_name: '', is_active: false|
                           Button::Component.new(class_name:, disabled:, id:, is_active:)
                         }

  renders_many :panels, ->(id:) { Panel::Component.new(id:) }
end
