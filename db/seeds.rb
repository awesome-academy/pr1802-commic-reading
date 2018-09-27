User.create!(name: "123",
  email: "123@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  admin: true)

30.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@domain.com"
  password = "123456"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password)
end

10.times do |n|
  name = "category#{n+1}"
  Category.create!(name: name)
end

10.times do |n|
  name = "author#{n+1}"
  Author.create!(name: name)
end

user = User.first
10.times do
  comic = user.comics.create!(
    title: Faker::Lorem.word,
    content: Faker::Lorem.sentence(2),
    author: Author.offset(rand(Author.count)).first,
    picture: Rails.root.join("app/assets/images/b73.jpg").open)
  ComicCategory.create!(category: Category.offset(rand(Category.count)).first, comic: comic)
end

user = User.first
comics = Comic.all
8.times do |n|
  title = "Chapter #{n+1}"
  comics.each do |comic|
    comic.chapters.create!(
      title: title,
      user_id: user.id,
      chapter_attachments_attributes:[ 
        {picture: Rails.root.join("app/assets/images/b73.jpg").open},
        {picture: Rails.root.join("app/assets/images/akb.jpg").open},
        {picture: Rails.root.join("app/assets/images/gengar.png").open},
        {picture: Rails.root.join("app/assets/images/geiz.jpg").open}
        ]
      )
  end
end
