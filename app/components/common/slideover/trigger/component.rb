class Common::Slideover::Trigger::Component < ApplicationComponent
  include Common::Slideover::Trigger

  option :id, Types::String, optional: true
  option :class_name, Types::String, optional: true
  option :variant, Types::Symbol.enum(:primary, :unstyled), default: -> { :primary }

  def style
    case variant
    when :primary
      'btn-primary btn-md'
    when :unstyled
      ''
    end
  end
end
