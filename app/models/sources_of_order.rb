class SourcesOfOrder < ApplicationRecord
  belongs_to :sources
  belongs_to :orders
end
