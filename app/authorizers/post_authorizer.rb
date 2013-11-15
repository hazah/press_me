class PostAuthorizer < ApplicationAuthorizer
  def readable_by?(user)
    super || begin
      case user_scope(user)
      when :anonymous
        resource.try(:status) == 'publish' || resource.published?
      end
    end
  end

  def self.readable_by?(user)
    super || begin

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

  class Published < PostAuthorizer
    def self.readable_by(user)
      true
    end
  end

  class Unpublished < PostAuthorizer
  end

end
