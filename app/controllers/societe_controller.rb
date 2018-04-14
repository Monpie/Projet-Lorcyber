class SocieteController < ApplicationController
  def initialize
    @societes = Societe.find_each
    if !$LOG
      $LOG = Log.new "#{Dir.home}/Documents/log.txt"
    end
  end

  def create
    @current_user = get_current_user
    if @current_user
      if check_access "admin"
        @societe = Societe.new
        @societe.nom_societe = params[:nom]
        @societe.referent = params[:ref]
        @societe.mail = params[:mail]
        @societe.adresse = params[:adresse]
        @societe.telephone = params[:tel]
        @societe.save

        time = Time.now
        $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, detected : { id: #{@societe.id}}"
      end
    end
    redirect_to societe_path
  end

  def index
    @current_user = get_current_user
  end

  def show
    @current_user = get_current_user
    if @current_user
      if check_access "admin"
        @societe = Societe.find(params[:id])
        time = Time.now
        $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}"
      end
    end
  end

  def delete
    @current_user = get_current_user
    if @current_user
      if check_access "admin"
        @societe = Societe.find(params[:id])
        time = Time.now
        $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, deleted : { id: #{@societe.id}, nom_societe: #{@societe.nom_societe}, referent: #{@societe.referent}}"
        @societe.delete
      end
    end
    redirect_to societe_path
  end

  def edit
    @current_user = get_current_user
    if @current_user
      if check_access "admin"
        @societe = Societe.find(params[:id])
        @societe.nom_societe = params[:nom]
        @societe.referent = params[:ref]
        @societe.mail = params[:mail]
        @societe.adresse = params[:adresse]
        @societe.telephone = params[:tel]
        @societe.save
        time = Time.now
        $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, detected : { id: #{@societe.id}}"
      end
    end
    redirect_to societe_path
  end

  private
  def get_current_user
    if session[:user_id]
      return Utilisateurs.find(session[:user_id])
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
