class OrderSource < ApplicationRecord
  belongs_to :order
  belongs_to :source
end
