# frozen_string_literal: true

# Comments model
class Comment < ApplicationRecord
  belongs_to :article
  validates_acceptance_of :human, allow_nil: false
end
