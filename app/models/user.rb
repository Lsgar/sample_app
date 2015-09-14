class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  attr_accessor :reset_token

  # before_save { email.downcase! }
  before_save { self.email = email.downcase }
  before_create :create_remember_token

  validates :name,  presence: true, length: { maximum: 50 }
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  # def User.new_remember_token
  #   SecureRandom.urlsafe_base64
  # end
  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  # def send_password_reset
  #   generate_token(:password_reset_token)
  #   self.password_reset_sent_at = Time.zone.now
  #   save!
  #   UserMailer.password_reset(self).deliver
  # end
  #
  # def generate_token(column)
  #   begin
  #     self[column] = SecureRandom.urlsafe_base64
  #   end while User.exists?(column => self[column])
  # end
  # Sets the password reset attributes.

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:password_reset_token, User.digest(reset_token).gsub(/[\.\/]/,"z"))  # . / がURIに含まれないようにgsubで置換
    update_attribute(:password_reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    # UserMailer.password_reset(self).deliver_now
    logger.debug('0')
    logger.debug(ENV['SMTP_ADDRESS'])
    logger.debug('1')
    logger.debug(ENV['SMTP_PORT'])
    logger.debug('2')
    logger.debug(ENV['SMTP_DOMAIN'])
    logger.debug('3')
    logger.debug(ENV['SMTP_USERNAME'])
    logger.debug('4')
    logger.debug(ENV['SMTP_PASSWORD'])
    logger.debug('5')
    logger.debug(ENV['SMTP_MAIL_PORT'])
    UserMailer.password_reset(self).deliver
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    password_reset_sent_at < 2.hours.ago
    # if user.password_reset_sent_at < 2.hours.ago
    #   return true
    # end
    #   return false
  end

  def feed
    # このコードは準備段階です。
    # 完全な実装は第11章「ユーザーをフォローする」を参照してください。
    # Micropost.where("user_id = ?", id)
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    self.relationships.find_by(followed_id: other_user.id)
  end

  def follow!(other_user)
    self.relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    self.relationships.find_by(followed_id: other_user.id).destroy
  end

  private

    def create_remember_token
      # self.remember_token = User.encrypt(User.new_remember_token)
      self.remember_token = User.encrypt(User.new_token)
    end

end
