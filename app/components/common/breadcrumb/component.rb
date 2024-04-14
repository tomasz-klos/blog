class Common::Breadcrumb::Component < ApplicationComponent
  option :class_name, Types::String.default(''), optional: true
  option :items, Types::Array.of(Types::Hash).default([])
end
