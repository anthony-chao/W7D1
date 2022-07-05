class User < ApplicationRecord
    after_initialize :ensure_session_token

    validates :user_name, presence: true, uniqueness: true
    validates :password_digest, presence: true 
    validates :session_token, presence: true, uniqueness: true 
    validates :password, length: {minimum: 6}

    attr_reader :password 
    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end

    def ensure_session_token
        self.session_token ||= SecureRandom::urlsafe_base64
    end

    def password=(password)

        @password = password                #Why do we assign it to @password?

        self.password_digest = BCrypt::Password.create(password)

    end

    def is_password?(password)
        password_object = BCrypt::Password.new(password) #Does new act like a search to find what the BCrypt version of the password string is?

        password_object.is_password?(password) 
    
    end

    def self.find_by_credentials(user_name, password)

        user = User.find_by(user_name: user_name)

         if user && user.is_password?(password)
            user        #why do we return user if the username/password pair are correct?
         else
            nil 
         end


           
    end


end
