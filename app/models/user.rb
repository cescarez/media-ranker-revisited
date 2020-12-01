class User < ApplicationRecord
  has_many :votes
  has_many :ranked_works, through: :votes, source: :work

  validates :username, uniqueness: true, presence: true
  validates :uid, uniqueness: {scope: :provider}, presence: true
  validates :email, :provider, presence: :true

  def self.build_from_github(auth_hash)
    user = User.new
    user.uid = auth_hash["raw_info"]["id"].to_s
    user.provider = 'github'
    user.username = auth_hash["raw_info"]["login"]
    user.email = auth_hash["raw_info"]["email"]
    return user
  end
end


