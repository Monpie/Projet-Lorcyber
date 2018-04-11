class Action < ApplicationRecord
  belongs_to :anomalie
  belongs_to :plan_action_type
end
