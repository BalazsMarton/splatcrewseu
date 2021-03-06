class Newsletter
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :email

  validates :email,
            presence: { message: "Kérjük adja meg email címét" }
  validates_format_of :email, :with => /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/, :message => "Kérjük valós email címet adjon meg"

end