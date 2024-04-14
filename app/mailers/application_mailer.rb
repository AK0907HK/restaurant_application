class ApplicationMailer < ActionMailer::Base
  #default from: "from@example.com"
  default from: 'restaurantaplication.heroku.com'
  layout "mailer"
end
