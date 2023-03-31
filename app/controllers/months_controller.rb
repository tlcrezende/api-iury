class MonthsController < ApplicationController
  def index
    render json: Month.all
  end
end
