class Image
  include Mongoid::Document
  include Mongoid::Paperclip

  field :description, type: String

  has_mongoid_attached_file :content, styles: { small: "320x240>",medium: "384x288>", large: "640x480>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :content, content_type: /\Aimage\/.*\z/
end
