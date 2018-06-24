class Comment < ApplicationRecord
  belongs_to :article
  # TODO: validates_acceptance_of :human
end
