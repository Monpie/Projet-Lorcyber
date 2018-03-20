class WelcomeController < ApplicationController
  def index
  end

  def connexion
    @current_user = Utilisateurs.where(nom: params[:name], password: params[:password]).first
    if @current_user

      flash[:info] = "Bienvenue #{@current_user.nom} !"
      create_file
      redirect_to "/anomalie"
    else
      flash[:info] = "Échec de la connexion"
      redirect_to "/welcome/index"
    end
  end

  def create_file
    file_name = "/home/kevin/Documents/log.txt"
    if not File.exist? file_name
      @log_file = File.new(file_name, File::CREAT|File::TRUNC|File::RDWR, 0644)
      time = Time.now
      @log_file << "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] Fichier créé"
      @log_file.close
    else
      @log_file = File.open file_name, "a"
      time = Time.now
      @log_file << "\n[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] user : #{@current_user.nom}, ip : #{request.remote_ip}"
      @log_file.close
    end

  end
end
