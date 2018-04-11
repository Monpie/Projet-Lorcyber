class UserController < ApplicationController

def initialize
  @Utilisateurs = Utilisateurs.find_each
end
end
