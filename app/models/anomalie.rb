class Anomalie < ApplicationRecord
  belongs_to :societe

  include ActiveModel::Validations
  validates :descriptif,
            presence: { message: "Vous devez indiquer un descriptif de l'alerte"},
            length: {maximum: 1000, message: "Nombre de caractères autorisés: 1000" }
  validates :societe,
            exclusion: {in: [nil] }

end
