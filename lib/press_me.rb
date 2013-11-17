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

          super.tap do |definition|
            singleton_class.send(:define_method, name) do |*args|
              scope = definition.call(*args)
              scope.authorizer = auth
              auth.scope = scope
            end
          end
        end

        def all
          auth = begin
            "#{self.name}Authorizer".constantize
          rescue NameError => e
            "ApplicationAuthorizer".constantize
          end

          super.tap do |scope|
            scope.authorizer = auth
            auth.scope = scope
          end
        end
      end

      module Relation
        attr_accessor :authorizer

        ::Authority.adjectives.each do |adjective|
          define_method("#{adjective}_by?") { |*args| authorizer.send("#{adjective}_by?", *args) }
        end
      end
    end
  end
end
