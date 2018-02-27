class PagesController < ApplicationController
  def home
    @transaction = Transaction.new
  end
end
