class User < ApplicationRecord

    before_save { email.downcase}

    validates :name, presence: true
    validates :email, presence: true,
     uniqueness: {case_sensitive: false}
    validates :password, presence: true, length: { minimum: 6} 
    # validate :unique_name_email_combination
    validate :different_password, on: :update

    def different_password
        if User.find_by(email: email).authenticate(password)
            errors.add(:must_be_different, "different password required")
        end 
    end 

    def unique_name_email_combination 
       if User.find_by(email: email, name: name) 
        errors.add(:name_email_must_be_unique, "unique name email combination rule")
       end  
    end 

    has_secure_password

end
