class Student < ApplicationRecord
  belongs_to :instructor
  validates :name, presence: true
  validates :instructor_id, presence: true, numericality: {only_integer: true}
  validates :age, numericality: { greater_than_or_equal_to: 18, only_integer: true}
end
