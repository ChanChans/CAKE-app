class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shipping_address, dependent: :destroy
  has_many :orders
  has_many :cart_items, dependent: :destroy

  validates :first_name, :last_name, :kana_first_name, :kana_last_name,
            :residence, :phone_number,
            presence: true
  validates :postal_code, length: {is: 7}, numericality: { only_integer: true }
  validates :phone_number, numericality: { only_integer: true }
  validates :kana_first_name, :kana_last_name,
      format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: "カタカナで入力して下さい。"}

  # 退会機能
  def active_for_authentication?
    super && (self.is_valid == false)
  end
end
