class PagesController < ApplicationController
  def show
    if valid_page?
      render template: "pages/#{params[:page]}"
    else
      render file: "#{Rails.root}/public/404", layout: false, status: :not_found
    end
  end

  private

  def valid_page?
    File.exist?(Pathname.new(Rails.root + "app/views/pages/#{params[:page]}.html.slim"))
  end
end
