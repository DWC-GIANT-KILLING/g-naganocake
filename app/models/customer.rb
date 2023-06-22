class Customer < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
    
    #has_many :cart_items
    #has_many :orders
    #has_many :addresses
    
    validates :last_name, presence: true
    validates :last_name_kana, format: { with: /\A[\p{katakana}\u{30fc}]+\z/, message: 'カタカナで入力してください。'}
    validates :first_name, presence: true
    validates :first_name_kana, format: { with: /\A[\p{katakana}\u{30fc}]+\z/, message: 'カタカナで入力してください。'}
    validates :postcode, format: { with: /\A\d{3}[-]\d{4}\z|\A\d{3}[-]\d{2}\z|\A\d{3}\z|\A\d{5}\z|\A\d{7}\z/ }
    validates :address, presence: true
    validates :phone_number, format: { with: /\A\d{10}\z|\A\d{11}\z/ }
    
    def full_name
      self.last_name+' '+self.first_name
    end
    
    
end
