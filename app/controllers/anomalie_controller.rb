class AnomalieController < ApplicationController
  def initialize
    @anomalies = Anomalie.find_each
  end

  def create
    @current_user = get_current_user
    @anomalie = Anomalie.new
    @anomalie.statut = "Alerte"
    @anomalie.descriptif = params[:descriptif]
    @anomalie.date = Time.now
    @anomalie.save
    time = Time.now
    $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, detected : { id: #{@anomalie.id}}"
    redirect_to anomalie_path
  end


  def show
    @current_user = get_current_user
    check_access "admin"
    if @current_user
      @anomalie = Anomalie.find(params[:id])
      time = Time.now
      $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}"
    end
  end

  def delete
    @current_user = get_current_user
    @anomalie = Anomalie.find(params[:id])
    time = Time.now
    $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, deleted : { id: #{@anomalie.id}, statut: #{@anomalie.statut}, desc: #{@anomalie.descriptif}, date: #{@anomalie.date}}"

    @anomalie.delete
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
      redirect_to anomalie_path
    else
      $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, alerte : true"
      @anomalie = Anomalie.find(params[:id])
      @anomalie.statut = "Incident"
      @anomalie.alerte_type = params[:type]
      @anomalie.save
      redirect_to anomalie_path
    end
  end

  private
  def get_current_user
    if session[:user_id]
      return Utilisateurs.find(session[:user_id])
    end
  end

  def check_access(access)
    @current_user = get_current_user
    if !@current_user || @current_user.role != access
      return head :forbidden
    end
  end
end
