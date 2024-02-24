require_relative '../types/types'

class ApplicationComponent < ViewComponent::Base
  extend Dry::Initializer
  include Turbo::StreamsHelper
  include Turbo::FramesHelper
end
