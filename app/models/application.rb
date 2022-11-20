# Schema: Application(token:string)

class Application < ApplicationRecord
  attribute :token

  has_many :chat

  before_create :set_token

  private
  def set_token
    self.token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(10)
      break token unless Application.where(token: token).exists?
    end
  end

  validates :name, uniqueness: true, presence: true
end
