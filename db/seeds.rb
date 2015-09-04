# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = HTTParty.get('http://jsonplaceholder.typicode.com/users')
users.each do |user|
  new_user = User.create(
    name: user['name'], username: user['username'], 
    email: user['email'], phone: user['phone'], 
    website: user['website'])
  user_address = Address.create( user_id: new_user.id,
    street: user['address']['street'], suite: user['address']['suite'],
    city: user['address']['city'], zipcode: user['address']['zipcode'])
end

albums = HTTParty.get('http://jsonplaceholder.typicode.com/albums')
albums.each do |album|
  new_album = Album.create(user_id: album['userId'], title: album['title'])
  photos = HTTParty.get("http://jsonplaceholder.typicode.com/photos?albumId=#{new_album.id}")
  photos.each do |photo|
    new_photo = Photo.create(
      album_id: photo['albumId'], title: photo['title'],
      url: photo['url'], thumbnail_url: photo['thumbnailUrl']
      )
  end
end
