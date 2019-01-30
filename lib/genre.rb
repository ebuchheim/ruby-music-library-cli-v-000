class Genre
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

    def add_song(song)
        if !@songs.include?(song)
            @songs << song
        end
    end

    def songs
        @songs
    end

    def artists
        artists = songs.map do |song|
            song.artist
        end
        artists.uniq
    end

    #CLASS METHODS below this line

    def self.create(name)
        new_genre = Genre.new(name)
        new_genre
    end

    def self.all
        @@all
    end

    def self.destroy_all
        @@all = []
    end
end