module Utility
  class UploadUsers
    def migrate_users
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
    end
  end

  class UploadAlbums
    def migrate_albums
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
    end
  end
end