class SpotifyService
  def artist_service
    @artist_service ||= ArtistsService.new
  end

  
  def albums_service
    @albums_service ||= AlbumsService.new
  end
  
  def songs_service
    @songs_service ||= SongsService.new
  end

  def get_artist(artist_new)
    artist = Artist.find_by(spotify_id: artist_new[:spotify_id])
    if  artist.present?
      artist
    else
      new_artist = Artist.new(artist_new.except(:genres, :albums))
      new_artist.save ? new_artist : nil
    end
  end

  def get_album(album_new)
    album = Album.find_by(spotify_id: album_new[:spotify_id])
    if  album.present?
      puts "Album Exist".colorize(:green)
      album
    else
      puts "Album Artist Success".colorize(:green)
      new_album = Album.new(album_new.except(:genres, :albums))
      new_album.save ? new_album : nil
    end
  end

  def get_song(song_new)
    song = Song.find_by(spotify_id: song_new[:spotify_id])
    if  song.present?
      puts "Song Exist".colorize(:green)
      song
    else
      puts "Create Artist Success".colorize(:green)
      new_song = Song.new(song_new.except(:genres, :albums))
      new_song.save ? new_song : nil
    end
  end

  def create_artist(data, spotify=false)
    artist = get_artist(data)
    create_genres(artist, data[:genres]) if spotify && data[:genres].present? && artist.present?
    create_albums(artist, data[:albums]) if spotify && data[:albums].present? && artist.present?
  end

  def create_genres(artist, genres)
    genres.each do |genre_spotify|
      genre = Genre.find_or_create_by(name: genre_spotify)
      artist_gender = ArtistGenre.new(artist_id: artist.id, genre_id: genre.id)
      artist_gender.save
    end
  end

  def create_albums( artist, albums )
    albums.each do |album|
      album_get = get_album(album)
      create_songs( album_get, album[:tracks] ) if album[:tracks].present? && album_get.present?
    end
  end

  def create_songs( album, songs )
    songs.each do |song|
      get_song(song)
    end
  end

  def migration_data_by_artist(artists_name)
    artist = Artist.find_by(name: artists_name)
    spotify = artist.present? ? false : true
    artist = artist_service.get_artist_by_name(artists_name) if !artist.present?
    new_artist = create_artist(artist, spotify) if artist.present?
  end

  def migration_albums_by_artist(artist)
    albums = albums_service.get_albums_by_artist(artist.spotify_id)
    create_albums(artist, albums)
  end

  def migration_songs_by_album(album)
    songs = songs_service.get_songs_by_album_id(album.spotify_id)
    create_songs(album, songs)
  end
end