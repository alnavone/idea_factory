class Idea < ApplicationRecord
  belongs_to :user, optional: true


  validates(:title, { presence: {message: 'must be provided'},
                      uniqueness: true })
  validates(:body, {length: {minimum: 5, maximum: 1000}})

end
