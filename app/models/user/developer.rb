class User::Developer < User
  def can_publish?(scope)
    true
  end
end
