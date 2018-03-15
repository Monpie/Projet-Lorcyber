class Societe < ApplicationRecord
  belongs_to :client
  belongs_to :anomalie
end
