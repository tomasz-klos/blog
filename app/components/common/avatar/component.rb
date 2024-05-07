class Common::Avatar::Component < ApplicationComponent
  option :class_name, optional: true
  option :size, default: -> { "md" }
  option :user

  def avatar_size
    {
      "sm" => "size-5",
      "md" => "size-8",
      "lg" => "size-16",
      "xl" => "size-24"
    }[size]
  end
end
