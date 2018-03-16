namespace :user do
  desc 'Creating authorizations= for users'
  task generate_auth: :environment do
    User.all.each do |user|
      user.authorizations.create(provider: user.provider, uid: user.uid)
    end
  end
end
