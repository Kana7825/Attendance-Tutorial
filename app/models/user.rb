class User < ApplicationRecord
  # ↑この継承の働きによりActive Recordのﾒｿｯﾄﾞが使える
  attr_accessor :remember_token
  # ↑「remember_token」という仮想の属性を作成します。
  before_save { self.email = email.downcase }
  #　↑before_saveメソッドにブロック{self.email=...｝を渡してﾕｰｻﾞｰのﾒﾙｱﾄﾞを設定
  #　↑現在のﾒﾙｱﾄﾞ（self.email）の値をdowncaseﾒｿｯﾄﾞを使って小文字に変換
  validates :name, presence: true, length: { maximum: 50}
  # ↑検証　名前の存在性あること、長さは50文字以下
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # ↑値が変化しないため、定数として定義＝引数として正規表現（Reguler Expression）、この正規表現でﾒﾙｱﾄﾞのﾌｫｰﾏｯﾄを検証できる
  validates :email, presence: true, length: { maximum:100},
                    format:{with: VALID_EMAIL_REGEX },
                    uniqueness: true# 一意性の検証
  validates :department, length: { in: 2..30 }, allow_blank: true
  validates :basic_time, presence: true
  validates :work_time, presence: true
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

# 渡された文字列のハッシュ値を返します。
  def User.digest(string)
    cost =
      if ActiveModel::SecurePassword.min_cost
         BCrypt::Engine::MIN_COST
      else
         BCrypt::Engine.cost
    end
  BCrypt::Password.create(string, cost: cost)
end

# ランダムなトークンを返します。
  def User.new_token
   SecureRandom.urlsafe_base64
  end

# 永続セッションのためハッシュ化したトークンをデータベースに記憶します。
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
# トークンがダイジェストと一致すればtrueを返します。
  def authenticated?(remember_token)
    # ダイジェストが存在しない場合はfalseを返して終了します。
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end 
  
# ユーザーのログイン情報を破棄します。
  def forget
    update_attribute(:remember_digest, nil)
  end
end
