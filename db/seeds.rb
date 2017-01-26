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


# home = Location.create({
#   id: 1,
#   street1: "123 Factoria BLVD",
#   city: "Bellevue",
#   state: "WA",
#   zip: "98005"
# })

# work = Location.create({
#   id: 2,
#   street1: "123 Main st",
#   city: "Seattle",
#   state: "WA",
#   zip: "98005"
# })

# Person.create({
#   id: 1,
#   first: "John",
#   last: "Smith",
#   phone: "206-555-1212",
#   home_address: home,
#   work_address: work,
# })
