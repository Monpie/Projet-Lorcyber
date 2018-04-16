class Utilisateurs < ApplicationRecord
  include ActiveModel::Validations

  validates :nom,
            presence: {message: "Vous devez saisir un nom d'utilisateur"},
            uniqueness: {message: "Nom déjà utilisé, veuillez en saisir un autre", case_sensitive: true},
            length: {maximum: 30, message: "Nombre de caractères autorisés: 30"},
            format: {with: /\A[a-zA-Z]+\z/, message: "Nom invalide : Seuls les lettres sont autorisées"}

  validates :password,
            presence: {message: "Vous devez saisir un mot de passe"},
            length: {minimum: 8, message: "Veuillez saisir un mot de passe contenant au minimum 8 caractères"},
            confirmation: { case_sensitive: true }

  validates :password_confirmation,
            presence: true

end
