class Todo < ApplicationRecord
  enum :priority, { Low: 0, Medium: 1, High: 2 }

  before_validation :set_default

  validates_presence_of :content
  validates_presence_of :created_by
  validates_presence_of :priority
  validates_presence_of :folder
  private

  def set_default
    self.folder = "default" if folder.blank?
  end
end
