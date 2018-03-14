namespace :user do
  desc 'Creating default categories for all current users'
  task generate_default_categories: :environment do
    User.find_each do |user|
      Users::DefaultCategoriesCreator.new(user).call
    end
  end
end
