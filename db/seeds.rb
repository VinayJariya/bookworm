User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             contact: "8319069564",
             password:              "foobar@123",
             password_confirmation: "foobar@123",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  contact = "9876543210"
  password = "password@123"
  User.create!(name:  name,
               email: email,
               contact: contact,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end