class Artist
    extend Concerns::Findable
    attr_accessor :name
    @@all = []

    def initialize(name)
        @name = name
        @songs = []
        @@all << self
    end

    def save
        @@all << self
    end

    def songs
        @songs
    end

    def add_song(song)
        if song.artist == nil
            song.artist = self
        end
        if !@songs.include?(song)
            @songs << song
        end
    end

    def genres
        genres = @songs.map do |song|
            song.genre
        end
        genres.uniq
    end

    #CLASS METHODS below this line

    def self.create(name)
        new_artist = Artist.new(name)
        new_artist
    end

    def self.destroy_all
        @@all = []
    end

    def self.all
        @@all
    end
end