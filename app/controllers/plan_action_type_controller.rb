class PlanActionTypeController < ApplicationController
  def initialize
    @anomalies = Anomalie.find_each
    @types = []

    @anomalies.each do |ano|
      unless ano.alerte_type.nil?
        unless @types.include?(ano.alerte_type)
           @types << ano.alerte_type
        end
      end
    end

    if !$LOG
      $LOG = Log.new "#{Dir.home}/Documents/log.txt"
    end

  end

  def index
    @current_user = get_current_user
    if @current_user
      if check_access "admin"
        @anomalie = Anomalie.find(params[:id])
        if @anomalie
          flash[:info] = "anomalie found"
        end
      else
        flash[:auth_error] = "Vous n'avez pas les droits requis pour accéder à cette page !"
      end
    else
      flash[:auth_error] = "Veuillez vous connecter pour accéder à cette page !"
    end
  end

  def generate(type)
    if @types.include?(type)
      case type
      when @types[0]
        return "Type = #{@types[0]}"
      when @types[1]
        return "Type = #{@types[1]}"
      end
    else
      return "Erreur sur le type de l'incident"
    end
  end

  private
  def get_current_user
    if session[:user_id]
      @current_user =  Utilisateurs.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def check_access(access)
    bool = false
    if @current_user
      if Droit.find(@current_user.droit_id).role == access
        bool = true
      end
    end
    return bool
  end

end
