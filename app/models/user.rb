class User < ApplicationRecord
  # ↑この継承の働きによりActive Recordのﾒｿｯﾄﾞが使える
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50}
  # ↑検証　名前の存在性あること、長さは50文字以下
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # ↑値が変化しないため、定数として定義＝引数として正規表現（Reguler Expression）、この正規表現でﾒﾙｱﾄﾞのﾌｫｰﾏｯﾄを検証できる
  validates :email, presence: true, length: { maximum:100},
                    format:{with: VALID_EMAIL_REGEX },
                    uniqueness: true# 一意性の検証
end

