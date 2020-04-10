require_relative "classes/game"

quit = true
    while quit
        game = Game.new
        game.yahtzee_banner
        game.enter
        game.play

        game.yahtzee_banner
        running = true
        while running
            puts "Do you want to play again? Y/N"
            input = gets.chomp.downcase
                if input == "y"
                    running = false
                elsif input == "n"
                    running = false
                    quit = false
                    game.yahtzee_banner
                    puts "Thanks for playing!"
                else
                    puts ""
                    puts "Please put in Y or N"
                end
        end
    end