class Common::Avatar::Component < ApplicationComponent
  option :class_name, optional: true
  option :size, default: -> { "md" }
  option :user

  def avatar_size
    {
      "sm" => "h-5 w-5",
      "md" => "h-8 w-8",
      "lg" => "h-12 w-12"
    }[size]
  end
end
