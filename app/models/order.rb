class Order < ActiveRecord::Base
  enum category: [:pictures, :literature, :music, :games, :gifs, :stuff]
  enum pricing: [:zero, :one, :two, :five, :ten]

  belongs_to :user

  validates_presence_of :user
  validates_presence_of :category
  validates_presence_of :pricing

end
