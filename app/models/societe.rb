class Societe < ApplicationRecord

  include ActiveModel::Validations

  validates :nom_societe,
            presence: { message: "Vous devez indiquer un nom"},
            uniqueness: { message: "La société existe déjà", case_sensitive: true },
            length: {maximum: 30, message: "Nombre de caractères autorisés: 30" }

  validates :referent,
            format: { with: /\A[a-zA-Z]+\z/, message: "Référent invalide : Les chiffres ne sont pas acceptés" },
            length: {maximum: 30, message: "Nombre de caractères autorisés: 30" }

  validates :adresse,
            length: {maximum: 100, message: "Nombre de caractères autorisés: 100" }

  validates :mail,
            length: {maximum: 30, message: "Nombre de caractères autorisés: 30" },
            format: {message: "Format du mail incorrect", with: /.+@.+\..+/i}

  validates :telephone,
            length: {maximum: 11, message: "Nombre de chiffres autorisés: 11"},
            numericality: {message: "Seuls les chiffres sont autorisés" }

end
