class Anomalie < ApplicationRecord
  belongs_to :societe

  include ActiveModel::Validations
  validates :descriptif, presence: true, length: {maximum: 1000, message: "Nombre de caractères autorisés: 1000" }
  validates :societe, exclusion: {in: [nil] }

end
