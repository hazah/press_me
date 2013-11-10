class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :type,            size: 32
      t.string    :email,           size: 60
      t.string    :password_digest, size: 255
      t.string    :nicename,        size: 50,   null: true
      t.string    :url,             size: 100,  null: true
      t.datetime  :registered
      t.string    :activation_key,  size: 60,   null: true
      t.integer   :status
      t.string    :display_name,    size: 250,  null: true

      t.timestamps
    end

    reversible do |direction|
      direction.instance_eval do
        up do
          User.create id: PressMe.anonymous, type: 'User::Anonymous', email: '',
            password: 'password', password_confirmation: 'password',
            registered: Time.now, status: 'active', display_name: 'Anonymous'

          User.create({type: 'User::Developer',
            email: 'email@example.com', password: 'password',
            password_confirmation: 'password', registered: Time.now,
            status: 'active', display_name: 'Administrator'}) { |user| PressMe.developer = user.id }
        end
      end
    end
  end
end
