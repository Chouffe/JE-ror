class User < ActiveRecord::Base
  validates :first_name, presence: true, length: { maximum: 100 }
  validates :last_name, presence: true, length: { maximum: 100 }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable
  has_attached_file :cv,
                    :url  => "/assets/products/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

  # validates_attachment_presence :cv
  validates_attachment_size :cv, :less_than => 5.megabytes
  validates_attachment_content_type :cv, :content_type => ['application/pdf'], :message => "only pdf files are allowed" 

  def full_name
    self.first_name + " " + self.last_name
  end
end
