class Common::Dropdown::Component < ApplicationComponent
  option :position, default: -> { 'center' }, optional: true
  option :menu_class, optional: true

  renders_one :button, Common::Dropdown::Button::Component

  def menu_position
    case position
    when 'left'
      'right-0'
    when 'right'
      'left-0'
    when 'center'
      'left-1/2 transform -translate-x-1/2'
    end
  end
end
