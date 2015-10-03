class Order < ActiveRecord::Base
  enum category: [:pictures, :literature, :music, :games, :gifs, :stuff]
  enum pricing: [:0, :1, :2, :5, :10]

  belongs_to :user

  validates_presence_of :user
  validates_presence_of :category
  validates_presence_of :pricing

end
