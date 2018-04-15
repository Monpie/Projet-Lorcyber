class AnomalieController < ApplicationController
  def initialize
    @anomalies = Anomalie.find_each
    @societes = Societe.find_each
    if !$LOG
      $LOG = Log.new "#{Dir.home}/Documents/log.txt"
    end
  end

  def create
    @current_user = get_current_user
    if @current_user
      if check_access "admin"
        @anomalie = Anomalie.new
        @anomalie.statut = "Alerte"
        @anomalie.descriptif = params[:descriptif]
        @anomalie.date = Time.now
        @anomalie.societe = Societe.find(1)
        @anomalie.save
        time = Time.now
        $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, detected : { id: #{@anomalie.id}}"
      end
    end
    render :file => "anomalie/index.html.erb",layout: "layouts/application.html.erb"
    #redirect_to anomalie_path
  end

  def index
    @current_user = get_current_user
    if @current_user
      time = Time.now
      $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}"
      @droits = Droit.find_each
      render layout: "layouts/application.html.erb"
    end
  end

  def show
    @current_user = get_current_user
    if @current_user && check_access("admin")
      @anomalie = Anomalie.find(params[:id])
      time = Time.now
      $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}"
      render layout: "layouts/application.html.erb"
    else
      redirect_to anomalie_path
    end
  end

  def delete
    @current_user = get_current_user
    @plans = PlanActionType.find_each
    if @current_user && check_access("admin")
      @anomalie = Anomalie.find(params[:id])
      time = Time.now
      @plans.each do |p|
        if p.anomaly_id == @anomalie.id
         p.delete
         $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, deleted_plan : { id: #{p.id}, anomaly_id: #{p.anomaly_id}, type: #{p.incident_type}, desc: #{p.descriptif}}"
        end
      end
      $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, deleted : { id: #{@anomalie.id}, statut: #{@anomalie.statut}, desc: #{@anomalie.descriptif}, date: #{@anomalie.date}}"
      @anomalie.delete
    end
    redirect_to anomalie_path
  end

  def alerte
    @current_user = get_current_user
    time = Time.now
    if params[:realAlerte] ==  "no"
      @anomalie = Anomalie.find(params[:id])
      @anomalie.statut = "Fausse alerte"
      @anomalie.alerte_type = nil
      @anomalie.save
      $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, alerte : false"
      render :file => "anomalie/index.html.erb",layout: "layouts/application.html.erb"
      #redirect_to anomalie_path
    else
      $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, alerte : true"
      @anomalie = Anomalie.find(params[:id])
      @anomalie.statut = "Incident"
      @anomalie.alerte_type = params[:type]
      @anomalie.save
      render :file => "anomalie/index.html.erb",layout: "layouts/application.html.erb"
      #redirect_to anomalie_path
    end
  end

  private
  def get_current_user
    if session[:user_id]
      return Utilisateurs.find(session[:user_id])
    end
  end

  def check_access(access)
    #@current_user = get_current_user
    #if !@current_user || Droit.find(@current_user.droit_id).role != access
    #  return head :forbidden
    #end
    bool = false
    if @current_user
      if Droit.find(@current_user.droit_id).role == access
        bool = true
      end
    end
    return bool
  end
end
