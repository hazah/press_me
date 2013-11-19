class PostAuthorizer < ApplicationAuthorizer
  def readable_by?(user)
    super || begin
      if user.roles.include?(:anonymous)
        resource.published?
      end
    end
  end

  def self.readable_by?(user)
    super || begin
      user.roles.include?(:administrator) || begin
        user.roles.include?(:anonymous) && scope.published? || begin
          user.roles.any? { |role| [:author].include? role } && begin
            scope.published? || scope.owned_by?(user)
          end
        end
      end
    end
  end

  def publishable_by?(user)
    super || begin
      if user.roles.include?(:administrator) || begin
        user.roles.include?(:author) && scope.owned_by?(user)
      end
    end
  end

  def self.publishable_by?(user)
    super || begin
      true
    end
  end

end
