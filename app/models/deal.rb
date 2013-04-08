class Deal < ActiveRecord::Base
  attr_accessible :title, :description, :discount, :end_at, :start_at, :files_ids, :conditions_attributes
  attr_accessor :files_ids
  
  has_many :conditions
  has_many :prices
  has_many :addresses
  has_many :tikets
  has_many :images

  accepts_nested_attributes_for :conditions, :allow_destroy => true

  after_save :append_attachments
  
  validates_presence_of :description, :discount, :end_at, :start_at, :title
  validates :discount, :numericality => true
  validate :dates
  

  
  def dates
    self.errors.add(:start_at, :less_than_or_equal_to, :count=>Deal.human_attribute_name("end_at")) if self.start_at > self.end_at
  end
  
  protected
  def append_attachments
    unless files_ids.blank?
      files_ids.each do |attach|
        attachment = Image.find(attach)
        attachment.update_attributes({:deal_id => id}) if attachment
      end
    end
  end
  
end
