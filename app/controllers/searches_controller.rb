class SearchesController < ApplicationController
protected
  def posts
    super.published
  end
end
