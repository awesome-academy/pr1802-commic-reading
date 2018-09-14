class User < ApplicationRecord
  attr_accessor :remember_token
  has_many :comics, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :followed_comics, through: :follows, source: :comic,
    dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :chapters
  has_many :rates
  has_many :rated_comics, through: :rates, source: :comic,
    dependent: :destroy
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create string, cost: cost
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def follow comic
    follows.create comic_id: comic.id
  end

  def unfollow comic
    follows.find_by(comic_id: comic.id).destroy
  end

  def following? comic
    comic.followers.find_by(id: id).present?
  end

  def rate comic
    rates.create comic_id: comic.id
  end

  def rating? comic
    comic.raters.find_by(id: id).present?
  end
end
