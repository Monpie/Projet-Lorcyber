class UserController < ApplicationController

  def initialize
    @Utilisateurs = Utilisateurs.find_each
    @droits = Droit.find_each
    if !$LOG
      $LOG = Log.new "#{Dir.home}/Documents/log.txt"
    end
  end

  def create
    get_current_user

    if new_check_access "admin"
      @utilisateur = Utilisateurs.new(user_params)
      if @utilisateur.save
        time = Time.now
        $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, new user : { id: #{@utilisateur.id}, droit : #{Droit.find(@utilisateur.droit_id).role}}"
      end
      render :file => "user/index.html.erb",layout: "layouts/application.html.erb"
    end
  end

  def show
    get_current_user
    if new_check_access("admin")
      time = Time.now
      $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}"
      check_access "admin"
      @utilisateur = Utilisateurs.find(params[:id])
      @droits = Droit.find_each
      render layout: "layouts/application.html.erb"
    else
      redirect_to user_path
    end
  end

  def index
    if get_current_user
      time = Time.now
      $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}"
      render layout: "layouts/application.html.erb"
    end
  end

  def edit
    get_current_user
    if new_check_access "admin"
      @utilisateur = Utilisateurs.find(user_params[:id])
      if @utilisateur.update(user_params)
          time = Time.now
          $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, user : {id: #{@utilisateur.id}, name : #{@utilisateur.nom}, role : #{Droit.find(@utilisateur.droit_id).role}}"
          #flash[:notice] = "Utilisateur ajoutée avec succès"
          redirect_to user_path
        else
          #flash[:notice] = "L'utilisateur n'a pas pu être ajoutée : Paramètres incorrects"
          render :file => "user/show.html.erb",layout: "layouts/application.html.erb"
      end
    end
=begin    if get_current_user
      if new_check_access("admin")
        @utilisateur = Utilisateurs.find(params[:id])
        unless last_admin?(@utilisateur)
          @utilisateur.nom = params[:nom]
          @utilisateur.droit_id = Droit.find(params[:role]).id
          @utilisateur.save
          time = Time.now
          $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, user : {id: #{@utilisateur.id}, name : #{@utilisateur.nom}, role : #{Droit.find(@utilisateur.droit_id).role}}"
        end
      end
    end
    redirect_to user_path
=end
  end



  def delete
    if get_current_user
    #  check_access "admin"
      if new_check_access "admin"
        @utilisateur = Utilisateurs.find(params[:id])
        time = Time.now
        unless last_admin?(@utilisateur)
          @utilisateur.delete
          $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, user : {id: #{@utilisateur.id}, name : #{@utilisateur.nom}}"
          if @utilisateur == @current_user
            redirect_to welcome_deconnexion_url
          else
            redirect_to user_path
          end
        else
          $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}, tried to delete last admin : {id: #{@utilisateur.id}, name : #{@utilisateur.nom}}"
          redirect_to user_path
        end
      end
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

  #Problème avec cette méthode
  def check_access(access)
    @current_user = get_current_user
    if !@current_user || Droit.find(@current_user.droit_id).role != access
      return head :forbidden
    end
  end

  def new_check_access(access)
    bool = false
    if @current_user
      if Droit.find(@current_user.droit_id).role == access
        bool = true
      end
    end
    return bool
 end

  def check_password_security
    bool = true;
    unless params[:password].nil?
      if params[:password].size < 8
        message = "Vous devez saisir un mot de passe d'au moins 8 caractère !"
        bool = false;
      end
    else
      message = "Vous devez saisir un mot de passe !"
      bool = false;
    end
    flash[:password_error] = message
    return bool
  end

##
# => Empêche la suppression du dernier utilisateur admin
# => Parcours toutes la liste des utilisateurs et vérifie qu'il y a un autre utilisateur admin
##
  def last_admin?(user)
    bool = false
    user_role = Droit.find(user.droit_id).role
    if user_role == "admin"
      bool = true
      @Utilisateurs.each do |u|
        if user_role == Droit.find(u.droit_id).role && u != user
          bool = false
        end
      end
    end
    return bool
  end

  def user_params
    params.require(:utilisateur).permit(:id,:nom, :password, :droit_id, :password_confirmation)
  end
end
