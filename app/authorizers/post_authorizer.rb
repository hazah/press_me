class PostAuthorizer < ApplicationAuthorizer
  def readable_by?(user)
    super || begin
      case user.class.name.demodulize.underscore.to_sym
      when :anonymous
        resource.try(:status) == 'publish' || resource.published?
      end
    end
  end

  def self.readable_by?(user)
    super || begin
      case user.class.name.demodulize.underscore.to_sym
      when :anonymous

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

private

  def self.readable_by_anonymous?

  end

end
