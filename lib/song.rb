class Song
    attr_accessor :name, :genre
    attr_reader :artist
    @@all = []

    def initialize(name, artist= nil, genre = nil)
        @name = name
        if !!genre
            self.genre=(genre)
        end
        if !!artist
            self.artist=(artist)
        end
        @@all << self
    end

    def save
        @@all << self
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.add_song(self)
    end

    #CLASS METHODS below this point

    def self.new_from_filename(filename)
        song_name = filename.split(" - ")[1]
        song_artist = filename.split(" - ")[0]
        song_genre = filename.split(" - ")[2]
        song_genre = song_genre.split(".")[0]
        song = self.new(song_name)
        song_artist = Artist.find_or_create_by_name(song_artist)
        song.artist=(song_artist)
        song_genre = Genre.find_or_create_by_name(song_genre)
        song.genre = song_genre
        song
    end

    def self.create_from_filename(filename)
        self.new_from_filename(filename)
    end

    def self.find_or_create_by_name(song)
        if !!self.find_by_name(song)
            self.find_by_name(song)
        else
            self.create(song)
        end
    end

    def self.find_by_name(name)
        song_array = @@all.map do |song| 
            if song.name == name
                song
            end
        end
        song_array[1]
    end

    def self.create(name)
        new_song = Song.new(name)
        new_song
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all = []
    end

end