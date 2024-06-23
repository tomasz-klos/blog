class Common::Avatar::Component < ApplicationComponent
  option :class_name, optional: true
  option :size, default: -> { "md" }
  option :user

  def avatar_size
    {
      "sm" => "size-5",
      "md" => "size-8",
      "lg" => "size-12",
      "xl" => "size-16",
      "2xl" => "size-24",
      "3xl" => "size-32",
      "4xl" => "size-40",
      "5xl" => "size-48",
      "6xl" => "size-56",
      "7xl" => "size-64",
      "8xl" => "size-72"
    }[size]
  end
end
