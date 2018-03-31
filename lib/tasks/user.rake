namespace :user do
  desc 'Creating default categories for all current users'
  task generate_default_categories: :environment do
    User.find_each do |user|
      Users::DefaultCategoriesCreator.new(user).call
    end
  end

  desc 'Convert current transactions to balance transactions'
  task convert_transactions: :environment do
    Transaction.find_each do |transaction|
      balance_transaction = BalanceTransaction.create(comment: transaction.comment)
      transaction.update(transactinable_type: BalanceTransaction,
                         transactinable_id: balance_transaction.id)
    end
  end

  desc 'Convert current categories to User categories polymorphic'
  task convert_categories: :environment do
    Category.all.each do |category|
      category.update!(categorizable_type: User, categorizable_id: category.user_id)
    end
  end
end
