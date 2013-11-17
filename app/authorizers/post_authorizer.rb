class PostAuthorizer < ApplicationAuthorizer
  def readable_by?(user)
    super || begin
      case user_scope(user)
      when :anonymous
        resource.published?
      end
    end
  end

  def self.readable_by?(user)
    super || begin
      case user_scope(user)
      when :anonymous
        scope.published?
      when :user
        scope.published? || scope.owned_by?(user)
      end
    end
  end

  def publishable_by?(user)
    super || begin
      true
    end
  end

  def self.publishable_by?(user)
    super || begin
      true
    end
  end

end
