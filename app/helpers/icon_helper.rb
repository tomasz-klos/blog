module IconHelper
  def icon(name, options = {})
    options[:title] ||= name.underscore.humanize
    options[:aria] = true
    options[:nocomment] = true
    options[:variant] ||= :fill
    options[:class] = options.fetch(:class_name, nil)
    path = options.fetch(:path, "icons/#{options[:variant]}/#{name}.svg")
    icon = path
    inline_svg_tag(icon, options)
  end
end
