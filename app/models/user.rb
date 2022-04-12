class User < ApplicationRecord
    # Validate that the name column is not empty
    validates :name, {presence: true}
    
    # Validate that the email column is unique and not empty
    validates :email, {presence: true, uniqueness: true}

    validates :password, {presence: true}
end
