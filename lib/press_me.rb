module PressMe
  module Authority
    module ActiveRecord
      module Scope
        def scope name, body, &block
          auth = begin
            Class.new "#{self.name}Authorizer".constantize
          rescue NameError => e
            "ApplicationAuthorizer".constantize
          end
          extension = Module.new { define_method(:authorizer) { auth }}

          super.tap do |definition|
            singleton_class.send(:define_method, name) do |*args|
              scope = definition.call(*args)
              auth.scope = scope.extending(extension)
            end
          end
        end
      end
    end
  end
end
