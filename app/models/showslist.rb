class Showslist < ApplicationRecord
  mount_uploader :filename, AudioUploader
  validates :live_date, length: { is: 8 }
  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、カラムを部分一致検索
      Showslist.where(['title LIKE ?', "%#{search}%"])
    else
      Showslist.all #全て表示。
    end
  end
end
