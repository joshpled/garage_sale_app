class Listing < ActiveRecord::Base
  belongs_to :user
  has_many :items
  validates :title, :description, presence: true
end
