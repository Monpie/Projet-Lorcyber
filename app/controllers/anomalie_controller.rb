class AnomalieController < ApplicationController
  def initialize

  end

  def show
    @anomalie = Anomalie.find(params[:id])
  end
end
