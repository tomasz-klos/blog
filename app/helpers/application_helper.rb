module ApplicationHelper
  def field_label_classes(form, field, custom_styles = {})
    classes = ['field-label']
    classes << custom_styles[:default] if custom_styles[:default].present?
    classes << 'error' if form.object.errors[field].any?
    classes.join(' ')
  end
end
