class Name < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  default_scope { order(last_name: :asc, first_name: :asc) }
end
