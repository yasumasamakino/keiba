class KaimeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.kaime_mailer.send_mail.subject
  #
  def send_mail(mailText)
    @honbun = mailText

    mail to: "yagu1031@gmail.com", subject: "買い目のお知らせ　取得時刻：" + Time.now.to_s
  end
end
