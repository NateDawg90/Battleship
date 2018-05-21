class Display

    attr_accessor :board, :size

    def initialize(board)
        @board = board
        @size = board.size
        moves = []
    end

    def render
        system("clear")
        print " "
        (0..size - 1).each do |num|
            if num > 9
                print "  #{num}"
            else 
                print "   #{num}"
            end 
        end
        puts "\n   " +"_"*(size*4)
        size.times do |x|
            if x > 9
                print "#{x}| "
            else
                print "#{x} | "
            end
            # debugger
            board.grid[x].each_index do |y|
            if board.grid[x][y]
                print board.grid[x][y] + " | "
            else
                print " " + " | "
            end
            end
            puts "\n   " + "_"*(size*4)
        end
    end
  
  end
  