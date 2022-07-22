class Trip < ApplicationRecord
  enum tp: [:day_trip, :multi_day_trip]

  validates :name, presence: true
  validates :trip_day, presence: true
  validates :museums, presence: true

  has_and_belongs_to_many :museums

  before_save :calc_tp
  
  def calc_tp
    if self.museums.size > 2
      self.tp = "multi_day_trip"
    elsif self.museums.size == 1
      self.tp = "day_trip"
    elsif self.museums.size == 2
      if self.museums.first.city == self.museums.last.city
        self.tp = "day_trip"
      else
        self.tp = "multi_day_trip"
      end
    end
  end
end
