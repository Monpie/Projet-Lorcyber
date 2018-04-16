class SocieteController < ApplicationController

  def initialize
    @societes = Societe.find_each
    if !$LOG
      $LOG = Log.new "#{Dir.home}/Documents/log.txt"
    end
  end

  def create
    @current_user = get_current_user
    if check_access "admin"
      @societe = Societe.new(societe_params)

      if @societe.save
        flash[:notice] = "Société ajoutée avec succès"
        flash[:color] = "valid"

      #  redirect_to @societe

      else
        flash[:notice] = "La société n'a pas pu être ajoutée : Paramètres incorrects"
        flash[:color] = "invalid"
        #render "index"
      end
    time = Time.now
    $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, detected : { id: #{@societe.id}}"
    end
    render :file => "societe/index.html.erb",layout: "layouts/application.html.erb"
    #redirect_to societe_path
  end

  def index
    @current_user = get_current_user
    render layout: "layouts/application.html.erb"

  end

  def show
    @current_user = get_current_user
    if @current_user
      if check_access "admin"
        @societe = Societe.find(params[:id])
        time = Time.now
        $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}"
        render layout: "layouts/application.html.erb"
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
        @societe = Societe.find(societe_params[:id])
        if @societe.update(societe_params)
          time = Time.now
          $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, edit societe : { id: #{@societe.id}}"
        end
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

  def societe_params
    params.require(:societe).permit(:id, :nom_societe, :referent, :mail, :adresse, :telephone)
  end
end
