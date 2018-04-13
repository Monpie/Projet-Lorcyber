class DroitController < ApplicationController
  def initialize
    @droits = Droit.find_each
  end

  def create

  end
end
