module PressMe
  module Authority
    module ActiveRecord
      module Scope
        def scope name, body, &block
          auth = begin
            ## I'm unsure as to why self.authorizer always returns 'ApplicationAuthorizer' here
            ## So I've overridden it to reuse the original algorithm.
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
          super.tap do |scope|
            scope.authorizer = begin
              ## I'm unsure as to why self.authorizer always returns 'ApplicationAuthorizer' here
              ## So I've overridden it to reuse the original algorithm.
              "#{self.name}Authorizer".constantize
            rescue NameError => e
              "ApplicationAuthorizer".constantize
            end
            scope.authorizer.scope = scope
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
