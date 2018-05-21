require_relative 'display'

SHIPS = { 
    'T' => {
        length: 2,
        placed: false,
    },  
    'D' => {
        length: 3,
        placed: false
    },  
    'S' => {
        length: 3,
        placed: false
    },  
    'B' => {
        length: 4,
        placed: false
    },  
    'C' => {
        length: 5,
        placed: false
    }
}
DIRECTIONS = ['L', 'R', 'U', 'D']

class Board
    attr_accessor :grid, :remaining_ships, :size

    def initialize(size)
        @size = size
        @grid = Array.new(size) { Array.new(size) }
        populate_board
        display
    end

    def populate_board
        count = 0
        SHIPS.keys.shuffle.each do |ship|
            while !SHIPS[ship][:placed]
                random_pos = [rand(@size), rand(@size)]
                try_pos(ship, random_pos)

            end
        end
    end

    def display
        display = Display.new(self)
        display.render
    end

    def check_direction(ship, loc, dir)
        ship_length = SHIPS[ship][:length]

        x, y = loc
        ship_length.times do
                
            if !valid_move?([x, y])
                return false
            end

            x, y = transform(x, y, dir)
        end
        return true
    end

    
    def place_piece(ship, loc, dir)
        ship_length = SHIPS[ship][:length]
        
        x, y = loc
        ship_length.times do
            grid[x][y] = ship
            x, y = transform(x, y, dir)
        end
        SHIPS[ship][:placed] = true
    end

    
    def try_pos(ship, loc)
        # tries to place piece in each direction
        DIRECTIONS.shuffle.each do |dir|
            x, y = loc
            valid = check_direction(ship, loc, dir)
            if valid 
                place_piece(ship, loc, dir)
                break
            end
        end
    end
    
    def transform(x, y, dir)
        if dir == 'L'
            y = y - 1
        elsif dir == 'U'
            x = x - 1
        elsif dir == 'D'
            x = x + 1
        elsif dir == 'R'
            y = y + 1
        end
        return x, y
    end

    def valid_move?(pos)
        x, y = pos
        if x.between?(0, size-1) && y.between?(0, size-1)
            return grid[x][y] ? false : true    
        end
        false
    end

end

if __FILE__ == $PROGRAM_NAME
    size = (ARGV[0] || 10).to_i
    Board.new(size)
end
