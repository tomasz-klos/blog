class Common::Dropdown::Component < ApplicationComponent
  option :position, default: -> { 'center' }, optional: true

  def menu_position
    case position
    when 'left'
      'right-0'
    when 'right'
      'left-0'
    end
  end
end
