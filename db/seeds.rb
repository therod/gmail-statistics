require 'mail'
require 'pry'

mail_path = '/Users/rodrigo/Mail/codegestalt/sent/cur/*'

mails = Dir.glob(mail_path)

# binding.pry

mails.each do |file|
  mail = Mail.read(file)
  guid = File.basename(file).split('_')[0]

  Email.create({
    guid: guid,
    from: mail.from,
    to: mail.to,
    subject: mail.subject,
    date: mail.date
  })
end
