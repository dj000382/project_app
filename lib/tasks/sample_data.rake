namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
		admin = User.create!(nom: "Example User",
								 prenom: "exemple",
                 email: "example@railstutorial.org",
								 labo: "info",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
			prenom = "exemple"
			labo = "info"
      password  = "password"
      User.create!(nom: name,
                   email: email,
									 prenom: prenom,
									 labo: labo,
                   password: password,
                   password_confirmation: password)
    end
		users = User.all(limit: 6)
    50.times do
      content = Faker::Lorem.sentence(5)
			year = 2011
			title = "Fake title"
      users.each { |user| user.publications.create!(content: content, title: title , year: year) }
    end
  end
end
