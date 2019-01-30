module Concerns::Findable
    attr_accessor :all
    def find_by_name(name)
        self.all.detect do |a|
            if a.name == name
                name
            end
        end
    end

    def find_or_create_by_name(song)
        if !!self.find_by_name(song)
            self.find_by_name(song)
        else
            self.create(song)
        end
    end


end