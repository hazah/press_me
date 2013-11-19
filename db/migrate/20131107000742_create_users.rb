class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string      :type,            size: 64,                  null: false, index: true
      t.string      :email,           size: 60,                  null: false, index: true
      t.string      :password_digest, size: 255,                 null: false
      t.string      :nicename,        size: 50,  default: '',    null: false, index: true
      t.string      :url,             size: 100, default: '',    null: false
      t.string      :activation_key,  size: 60,  default: '',    null: false
      t.integer     :status,                     default: 0,     null: false
      t.string      :display_name,    size: 250, default: '',    null: false
      t.boolean     :spam,                       default: false, null: false
      t.boolean     :deleted,                    default: false, null: false

      t.timestamps null: false
    end

    reversible do |direction|
      direction.instance_eval do

        up do
          User.create id: PressMe.anonymous, type: 'User::Anonymous', email: '',
            password: 'password', password_confirmation: 'password',
            roles: [:anonymous], status: 'active', display_name: 'Anonymous'

          User.create({type: 'User::Developer',
            email: 'email@example.com', password: 'password', roles: [:administrator],
            password_confirmation: 'password', status: 'active',
             display_name: 'Developer'}) { |user| PressMe.developer = user.id }
        end
      end
    end
  end
end
