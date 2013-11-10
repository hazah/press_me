class PostAuthorizer < ApplicationAuthorizer
  def publishable_by?(user)
    super || begin
      # TODO: Determine how users can publish
    end
  end

  def self.publishable_by?(user)
    super || begin
      # TODO: Determine how users can publish
    end
  end

end
