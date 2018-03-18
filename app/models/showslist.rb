class Showslist < ApplicationRecord
  mount_uploader :filename, AudioUploader
  validates :live_date, length: { is: 8 }
  validates :length, presence: true, length: { minimum: 1 }
  validates :playtime, presence: true, length: { minimum: 1 }
  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、カラムを部分一致検索
      Showslist.where(['title LIKE ?', "%#{search}%"]).order(live_date: :DESC)
    else
      Showslist.order(live_date: :DESC) #全レコードを演奏日降順表示。
    end
  end
end
