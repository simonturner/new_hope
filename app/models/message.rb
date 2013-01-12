class Message
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  NEW_HOPE = 'newhope.reciever@gmail.com'
  BRIDGES = 'building_briges@email.com'
  attr_accessor :name, :new_hope, :bridges, :phone, :email, :confirmation, :subject, :content
  validates_presence_of :name
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_length_of :content, :maximum => 500
  
  @to
  
  def to
    @to = Array.new
    if new_hope
      @to << NEW_HOPE
    end
    if bridges
      @to << BRIDGES
    end
    if confirmation
      @to << @email
    end
    @to
  end
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
end