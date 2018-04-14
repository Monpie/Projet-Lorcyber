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
        if params[:id]
          @anomalie = Anomalie.find(params[:id])
          time = Time.now
          $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, plan_index : {  anomalie_id: #{@anomalie.id}}"
        else
          @plans = PlanActionType.find_each
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

  def show
    if check_access "admin"
      @anomalie = Anomalie.find(params[:id])
    else
      redirect_to plan_path
    end
  end

  def create
    @current_user = get_current_user
    @anomalie = Anomalie.find(params[:anomalie_id])
    if params[:anomalie_id]
      date = params[:date].to_date
      now = Date.today
      if (date.day < now.day && date.month <= now.month && date.year <= now.year) || (date.month < now.month && date.year <= now.year) || (date.year < now.year)
        flash[:date_error] = "Veuillez saisir une date correcte !"
      else
        @plan = PlanActionType.new
        @plan.incident_type = @anomalie.alerte_type
        @plan.descriptif = params[:descriptif]
        @plan.liste_action = params[:actions]
        @plan.temps = params[:date]
        @plan.priorite = params[:priorite]
        @plan.anomaly_id = @anomalie.id
        @plan.save
        time = Time.now
        $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, generate plan : { id: #{@plan.id}, anomlie_id : #{@plan.anomaly_id}}"
      end
      redirect_to plan_path<<"?id=#{@anomalie.id}"
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
    @current_user = get_current_user
    if @current_user
      if Droit.find(@current_user.droit_id).role == access
        bool = true
      end
    end
    return bool
  end

end
