class WelcomeController < ApplicationController
  $LOG = Log.new "#{Dir.home}/Documents/log.txt"
  def index
    if session[:user_id]
      @current_user = Utilisateurs.find(session[:user_id])
    end
  end

  def connexion
    @current_user = Utilisateurs.where(nom: params[:name], password: params[:password]).first
    if @current_user
      session[:user_id] = @current_user.id
      flash[:info] = "Bienvenue #{@current_user.nom} !"
      #log = Log.new "#{Dir.home}/Documents/log.txt"
      time = Time.now

      $LOG.write "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}, route : #{request.fullpath}"

      #flash[:info] = request.fullpath #Récupère seulement la route
      #flash[:info] = request.env['PATH_INFO'] #Meme chose que fullpath
      #request.original_url #Récupère l'URL original complète
      redirect_to "/anomalie"
    else
      session[:user_id] = nil
      flash[:info] = "Échec de la connexion"
      redirect_to "/welcome/index"
    end
  end

  def deconnexion
    unless session[:user_id].nil?
      session[:user_id] = nil
    end

    redirect_to "welcome/index"
  end
end
