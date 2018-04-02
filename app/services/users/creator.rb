class Users::Creator < Struct.new(:email)
  def call
    create_user
    add_default_categories
    @user
  end

  private

  def create_user
    @user = User.create(
      email: email,
      password: generate_password,
      confirmed_at: Date.current
    )
  end

  def generate_password
    Devise.friendly_token[0, 20]
  end

  def add_default_categories
    Users::DefaultCategoriesCreator.new(@user).create_default_categories
  end
end
