PressMe.account_class = User

Warden::Strategies.add :email_password do
  def valid?
    params[:email] || params[:password]
  end

  def authenticate!
    if account = PressMe.account_class.find_by_email(params[:email])
      account.authenticate(params[:password]).tap do |a|
        a.nil? ? fail!("Authentication Failed") : success!(a)
      end
    end
  end
end

Warden::Strategies.add :global do
  def valid?
    true
  end

  def authenticate!
    success! PressMe.account_class.global.first
  end
end

Warden::Strategies.add :developer do
  def valid?
    Rails.env.development?
  end

  def authenticate!
    success! PressMe.account_class.developer.first
  end
end

Warden::Manager.serialize_into_session do |account|
  account.id
end

Warden::Manager.serialize_from_session do |id|
  PressMe.account_class.find id
end
