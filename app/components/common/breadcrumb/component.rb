class Common::Breadcrumb::Component < ApplicationComponent
  option :class_name, optional: true
  option :items, Types::Array.of(Types::Hash)
end
