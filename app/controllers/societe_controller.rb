class SocieteController < ApplicationController
  def initialize
    @societes = Societe.find_each
  end

  def create
    @current_user = get_current_user
    @societe = Societe.new
    @societe.nom_societe = params[:nom]
    @societe.referent = params[:ref]
    @societe.mail = params[:mail]
    @societe.adresse = params[:adresse]
    @societe.telephone = params[:tel]
    @societe.save

    time = Time.now
    #$LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, detected : { id: #{@societe.id}}"
    redirect_to societe_path
  end


  def show
    @current_user = get_current_user
    check_access "admin"
    if @current_user
      @societe = Societe.find(params[:id])
      time = Time.now
     # $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}"
    end
  end

  def delete
    @current_user = get_current_user
    @societe = Societe.find(params[:id])
    time = Time.now
   # $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, deleted : { id: #{@societe.id}, nom_societe: #{@societe.nom_societe}, referent: #{@societe.referent}}"
    @societe.delete
    redirect_to societe_path
  end

  def edit
    @current_user = get_current_user
    @societe = Societe.find(params[:id])
    @societe.nom_societe = params[:nom]
    @societe.referent = params[:ref]
    @societe.mail = params[:mail]
    @societe.adresse = params[:adresse]
    @societe.telephone = params[:tel]
    @societe.save
    time = Time.now
    #$LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, detected : { id: #{@societe.id}}"
    redirect_to societe_path
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
