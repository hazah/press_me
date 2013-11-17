module PressMe
  module Authority
    module ActiveRecord
      module Scope
        def scope name, body, &block
          authorizer = self.authorizer.dup
          super.tap do |definition|
            singleton_class.send(:define_method, name) do |*args|
              definition.call(*args).tap do |scope|
                authorizer.scope = scope
              end
            end
          end
        end
      end
    end
  end
end
