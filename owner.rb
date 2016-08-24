require 'csv'

module Bank
  class Owner
    attr_accessor :id

    def initialize(id, last_name, first_name, address, city, state)
      @id = id
      @last_name = last_name
      @first_name = first_name
      @address = address
      @city = city
      @state = state
    end

    def self.all
      owners = []
      CSV.read('support/owners.csv').each do |line|
        owners << self.new(line[0], line[1], line[2], line[3], line[4], line[5])
      end
      owners
    end

    def self.find(id)
      owners = self.all
      owners.each do |owner|
        if owner.id == id
          return owner
        end
      end
    end
  end
end
