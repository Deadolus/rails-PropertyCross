class HomeController < ApplicationController
  def index
  end

  def help

  end

  def invalid_route
      flash[:alert] = "Invalid request, nothing to see here"
      redirect_to root_path
  end

end
