class Chat < ApplicationRecord
  belongs_to :application

  before_save :set_number

  private
  def set_number
    if Chat.count > 0
      self.number = Chat.maximum(:id) + 100
    else
      self.number = 100
    end
  end
end

