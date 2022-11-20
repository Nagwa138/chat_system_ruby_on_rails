class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat

  validates :body, presence: true

  before_save :set_number

  private
  def set_number
    if Message.count > 0
      self.number = Message.maximum(:id) + 100
    else
      self.number = 100
    end
  end
end
