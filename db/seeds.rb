# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

unless User.exists?(email: "asd@asd.com")
  User.create!(email: "asd@asd.com", password: "asdasdasd", admin: true)
end

unless User.exists?(email: "a@a.com")
  User.create!(email: "a@a.com", password: "asdasdasd")
end

["sublime", "atom"].each do |project|
  unless Project.exists?(name: project)
    Project.create(name: project, description: "a sample project about #{project}")
  end
end
