class PlanActionTypeController < ApplicationController
  def initialize
    @anomalies = Anomalie.find_each
    @types = []

    @anomalies.each do |ano|
      unless ano.alerte_type.nil?
        unless @types.include?(ano.alerte_type)
           @types << ano.alerte_type
        end
      end
    end
  end

  def generate(type)
    if @types.include?(type)
      case type
      when @types[0]
        return "Type = #{@types[0]}"
      when @types[1]
        return "Type = #{@types[1]}"
      end
    else
      return "Erreur sur le type de l'incident"
    end
  end
end
