namespace :db do
  desc "Generate users"
  task populate: :environment do
    # Generate fixed users Yitao, Ed and pcc
  	yitao = User.create(name: "Yitao", email: "yitao@example.com")
  	ed = User.create(name: "Ed", email: "ed@example.com")
    pcc = User.create(name: "pcc", email: "pcc@gmail.com")

    # Generate 98 additional random users
      users = [ yitao, ed, pcc ]
      users += 98.times.collect do |i|
      name = Faker::Name.name
      email = i < 10 ? name.split.join : "#{name.split.join}@example.com"
      user = User.create(name: name, email: email)
    end

    # Randomize user created_at timestamp
    users.each { |user| user.update(created_at: Date.today - rand(31)) }
    
    # Generate random posts
    posts = (10*users.count).times.collect do
      (user.sample).posts.create(content: Faker::Lorem.sentence)
    end
  end
end