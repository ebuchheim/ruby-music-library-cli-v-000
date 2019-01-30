class MusicLibraryController
    attr_accessor :path

    def initialize(path = "./db/mp3s")
        @path = path
        files = MusicImporter.new(path)
        @my_songs = files.import
    end

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"
        user_input = gets.chomp
        if !user_input.match(/list songs|list artists|list genres|list artist|list genre|play song|exit/)
            self.call
        end
        if user_input == "list songs"
            list_songs
        end
        if user_input == "list artists"
            list_artists
        end
        if user_input == "list genres"
            list_genres
        end
        if user_input == "list artist"
            list_songs_by_artist
        end
        if user_input == "list genre"
            list_songs_by_genre
        end
        if user_input == "play song"
            play_song
        end
    end

    def list_songs
        sorted_songs = Song.all.sort do |a, b|
            a.name <=> b.name
        end
        count = 1
        sorted_songs.each do |song|
            puts "#{count}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
            count += 1
        end
    end

    def list_artists
        sorted_artist = Artist.all.sort do |a, b|
            a.name <=> b.name
        end
        count = 1
        sorted_artist.each do |artist|
            puts "#{count}. #{artist.name}"
            count += 1
        end
    end

    def list_genres
        sorted_genre = Genre.all.sort do |a, b|
            a.name <=> b.name
        end
        count = 1
        sorted_genre.each do |genre|
            puts "#{count}. #{genre.name}"
            count += 1
        end
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        user_input = gets.chomp
        artist = Artist.find_by_name(user_input)
        songs_array = []
        Song.all.map do |song|
            if song.artist == artist
                songs_array << song
            end
        end
        sorted_array = songs_array.sort do |a, b|
            a.name <=> b.name
        end
        count = 1
        sorted_array = sorted_array.each do |song|
            puts "#{count}. #{song.name} - #{song.genre.name}"
            count += 1
        end
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        user_input = gets.chomp
        genre = Genre.find_by_name(user_input)
        songs_array = []
        Song.all.map do |song|
            if song.genre == genre
                songs_array << song
            end
        end
        count = 1
        songs_array.each do |song| 
            puts "#{count}. #{song.artist.name} - #{song.name}"
            count += 1
        end
    end

    def play_song
        sorted_songs = Song.all.sort do |a, b|
            a.name <=> b.name
        end
        total = sorted_songs.count
        puts "Which song number would you like to play?"
        user_input = gets.chomp
        if user_input.to_i >= 1 && user_input.to_i <= total
            user_input = user_input.to_i
            index = user_input - 1
            song = sorted_songs[index]
            if !!song 
                puts "Playing #{song.name} by #{song.artist.name}"
            end
        end
    end
end