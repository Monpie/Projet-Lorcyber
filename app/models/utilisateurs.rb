class Utilisateurs < ApplicationRecord
  include ActiveModel::Validations

  validates :nom,
            presence: {message: "Vous devez saisir un nom"},
            uniqueness: {message: "Nom déjà utilisé, veuillez en saisir un nouveau", case_sensitive: true},
            length: {maximum: 30, message: "Nombre de caractères autorisés: 30"},
            format: {with: /\A[a-zA-Z]+\z/, message: "Nom invalide : Seuls les lettres sont autorisés"}

  validates :password,
            presence: {message: "Vous devez saisir un mot de passe"},
            length: {minimum: 8, message: "Veuillez saisir un mot de passe contenant au minimum 8 caractères"}

end
