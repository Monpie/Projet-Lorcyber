=begin
  Classe représentant la gestion des logs
=end
class Log
  def initialize(file_name = "#{Dir.home}/Documents/log.txt")
    @file_name = file_name
  end

  def write(message)
    if File.exist? @file_name
      @file = File.open @file_name, "a"
      @file << "#{message}\n"
      @file.close
    else
      @file = create_file
      time = Time.now
      @file << "[#{Time.utc time.year, time.month, time.day, time.hour, time.min, time.sec}] Fichier créé \n#{message}\n"
      @file.close
    end
  end

  def read

  end

  private
  def create_file
    File.new @file_name, File::CREAT|File::TRUNC|File::RDWR, 0644
  end

end
