class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :last_name, :first_name, :last_name_kana, :first_name_kana, :birth_date, presence: true

  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  validates :last_name, :first_name, format: { with: VALID_NAME_REGEX, message: 'is invalid. Input full-width characters' }

  VALID_KANA_REGEX = /\A[ァ-ヶー－]+\z/
  validates :last_name_kana, :first_name_kana,
            format: { with: VALID_KANA_REGEX, message: 'is invalid. Input full-width katakana characters' }

  validates :password, format: {
    with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/,
    message: 'is invalid. Include both letters and numbers'
  }, if: -> { password.present? }
end
