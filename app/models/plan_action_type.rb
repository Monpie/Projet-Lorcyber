class PlanActionType < ApplicationRecord
  include ActiveModel::Validations

  validates :descriptif,
            presence: {message: "Vous devez saisir une description concernant l'incident"},
            length: {maximum: 200, message: "Nombre de caractères autorisés: 200"}

  validates :temps,
            presence: {message: "Veuillez saisir une date à laquelle l'incident doit être clos"}

  validates :priorite,
            presence: {message: "Veuillez indiquer la priorité de traitement de l'incident"}

  validates :anomaly_id,
            presence: {message: "Un plan d'action doit être lié à une anomalie"}
end
