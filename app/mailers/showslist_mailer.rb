class ShowslistMailer < ApplicationMailer
  def showslist_mail(showslist)
 @showslist = showslist

 mail to: "bombknee@gmail.com", subject: "Showslists Updated!"
end
end
