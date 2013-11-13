class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string      :email,           size: 60,                  null: false, index: true
      t.string      :password_digest, size: 255,                 null: false
      t.string      :nicename,        size: 50,                  null: false, index: true
      t.string      :url,             size: 100,                 null: false
      t.string      :activation_key,  size: 60,                  null: false
      t.integer     :status,                     default: false, null: false
      t.string      :display_name,    size: 250,                 null: false
      t.boolean     :spam,                       default: false, null: false
      t.boolean     :deleted,                    default: false, null: false

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
