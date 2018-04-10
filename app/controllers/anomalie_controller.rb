class AnomalieController < ApplicationController
  def initialize
    @anomalies = Anomalie.find_each
  end

  def show
    get_current_user
    @anomalie = Anomalie.find(params[:id])
    time = Time.now
    $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}"
  end

  def delete
    @anomalie = Anomalie.find(params[:id])
    get_current_user
    time = Time.now
    $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, deleted : { id: #{@anomalie.id}, statut: #{@anomalie.statut}, desc: #{@anomalie.descriptif}, date: #{@anomalie.date}}"

    @anomalie.delete
    redirect_to anomalie_path
  end

  def alerte
    get_current_user
    time = Time.now
    if params[:realAlerte] ==  "no"
      $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, alerte : false"
      redirect_to root_path
    else
      $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, alerte : true"
      redirect_to anomalie_path
    end
  end

  private
  def get_current_user
    if session[:user_id]
      @current_user = Utilisateurs.find(session[:user_id])
    end
  end
end
