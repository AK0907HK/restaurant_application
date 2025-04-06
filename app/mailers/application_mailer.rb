class ApplicationMailer < ActionMailer::Base
  #default from: "from@example.com"
  #default from: 'restaurantaplication.heroku.com'
  default from: "no-reply@restaurant-chooser.com"
  layout "mailer"
end
