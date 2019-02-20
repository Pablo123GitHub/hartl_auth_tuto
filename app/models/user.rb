class User < ApplicationRecord

    before_save { email.downcase}

    validates :name, presence: true
    validates :email, presence: true,
     uniqueness: {case_sensitive: false}
    validates :password, presence: true, length: { minimum: 6} 
    validate :unique_name_email_combination


    def unique_name_email_combination 
       if User.find_by(email: email, name: name) 
        errors.add(:name_email_must_be_unique, "unique name email combination rule")
       end  
    end 

    has_secure_password

end
