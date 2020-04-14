require_relative "dice"
require_relative "player"

class Game

    def initialize
        d1 = Dice.new
        d2 = Dice.new
        d3 = Dice.new
        d4 = Dice.new
        d5 = Dice.new
        @dice_set = [d1,d2,d3,d4,d5]
        @rounds = 1
        # yahtzee_banner
        # add_players
    end

    def yahtzee_banner
        system 'clear'
        puts"      )                )               )              "
        puts"      ( /(     (       ( /(    *   )   ( /(            "  
        puts"      )\\())    )\\      )\\()) ` )  /(   )\\())  (     (   " 
        puts"     ((_)\\  ((((_)(   ((_)\\   ( )(_)) ((_)\\   )\\    )\\   "
        puts"    __ ((_)  )\\ _ )\\   _((_) (_(_())   _((_) ((_)  ((_)  "
        puts"    \\ \\ / /  (_)_\\(_) | || | |_   _|  |_  /  | __| | __| "
        puts"     \\ V /    / _ \\   | __ |   | |     / /   | _|  | _|  "
        puts"      |_|    /_/ \\_\\  |_||_|   |_|    /___|  |___| |___|"
        puts" ********************************************************** "
    end

    def enter
        puts ""
        puts "Press any key to continue"
        gets
    end

    def add_players ############## ADD ONE PLAYER MODE AND FIX P1 P2
        puts "How many players? 2 -- 5:"
        input = validate_player_number
        case input
            when "2"
                p1 = Player.new("Player 1")
                p2 = Player.new("Player 2")
                @players = [p1,p2]
            when "3"
                p1 = Player.new("Player 1")
                p2 = Player.new("Player 2")
                p2 = Player.new("Player 3")
                @players = [p1,p2,p3]
            when "4"
                p1 = Player.new("Player 1")
                p2 = Player.new("Player 2")
                p1 = Player.new("Player 3")
                p2 = Player.new("Player 4")
                @players = [p1,p2,p3,p4]
            when "5"
                p1 = Player.new("Player 1")
                p2 = Player.new("Player 2")
                p1 = Player.new("Player 3")
                p2 = Player.new("Player 4")
                p2 = Player.new("Player 5")
                @players = [p1,p2,p3,p4,p5]
        end
    end

    def play
        @round = 1
        yahtzee_banner
        add_players
        yahtzee_banner
        until @rounds == 14
            @playernum = 0
            for x in @players
                round
                scoring(@players,@playernum)
                @playernum +=1
                @dice_set.each {|x|x.roll}
                next
            end
            @rounds += 1
        end
        check_for_winner
    end

    def round
        quit = false
        rolls = 1
        until quit || rolls == 3
            yahtzee_banner
            dice_display
            @players[@playernum].current_scorecard
            puts "Do you want to re-roll? Y/N"
            input = gets.chomp.downcase
                if input == "n" #quit round
                    quit = true
                elsif input == "y" #re-roll and increase rolls
                    dice_roller
                    rolls += 1
                else #back to reroll q without increasing rolls
                    puts "Please enter Y or N"
                    enter
                end
        end
    end

    def dice_roller
        puts ''        
        puts "Which dice do you want to keep? Example: '1 2 3' or '2 5'"
        keep = validate_dice_rollkeep
        puts "Rolling..." #ANimations??
        range = [1,2,3,4,5]
        keep.split.map{|x| x.to_i}.each {|x| range.delete(x)}
        range.each {|x| @dice_set[(x-1)].roll}
    end

    def check_for_winner
        yahtzee_banner
        winner = {}
        @players.each {|x| winner[x.name] = x.total_score}
        winner = winner.sort_by {|k,v| v}.flatten[-2,2]
        puts ""
        puts "The winner is....."
        puts "#{winner[0]} with #{winner[1]} points!"
        puts ""
        puts "Nice work!!"
        enter
    end

    def scoring(playersarr,playernum)
        yahtzee_banner
        dice_display
        dice_set = @dice_set.map {|x| x.value}
        scorearr = playersarr[playernum].score(dice_set)
        scorebox(scorearr)
        puts "Which box do you want to score?"
        input = validate_box_score(scorearr)
        playersarr[playernum].update_score(scorearr,input)
        puts "Score updated!"
        puts "Your total score is now #{playersarr[playernum].total_score}"
        enter      

    end

    private

    def validate_player_number
        input = gets.chomp
        until input == "2" || input == "3" || input == "4" || input == "5"
            yahtzee_banner
            puts "I'm sorry, that's not a valid input."
            enter
            yahtzee_banner
            puts "How many players? 2 -- 5:"
            input = gets.chomp            
        end
        return input
    end

    def validate_box_score(scorearr)
        input = getint
        running = true
        while running
            if input < 1 && input > 13
                yahtzee_banner
                dice_display
                scorebox(scorearr)
                puts "I'm sorry, that's not a valid input."
                enter
                yahtzee_banner
                dice_display
                scorebox(scorearr)
                puts "Which box do you want to score?"
                input = getint

            elsif scorearr[input - 1].to_s.split(//).last == "*"
                yahtzee_banner
                dice_display
                scorebox(scorearr)
                puts "I'm sorry, you've already scored that box"
                enter
                yahtzee_banner
                dice_display
                scorebox(scorearr)
                puts "Which box do you want to score?"
                input = getint
            else
                running = false
            end
        end
        return (input - 1)
    end

    def validate_dice_rollkeep
        input = gets.chomp
        comparer = input.split.first

        until comparer == "0" || comparer == "1" || comparer == "2" || comparer == "3" || comparer == "4" || comparer == "5"
            yahtzee_banner
            dice_display
            @players[@playernum].current_scorecard
            puts "I'm sorry, that's not a valid input."
            enter
            yahtzee_banner
            dice_display
            @players[@playernum].current_scorecard
            puts "Which dice do you want to keep? Example: '1 2 3' or '2 5'"
            input = gets.chomp
            comparer = input.split.first 
        end
        return input
    end

    def dice_display
        puts "          Player: #{@players[@playernum].name} | Score: #{@players[@playernum].total_score} | Round: #{@rounds}"
        puts ""
        puts "          #1       #2       #3       #4       #5" 
        puts "        ______   ______   ______   ______   ______"
        puts "       |      | |      | |      | |      | |      |"
        puts "       |  #{@dice_set[0].value}   | |  #{@dice_set[1].value}   | |  #{@dice_set[2].value}   | |  #{@dice_set[3].value}   | |  #{@dice_set[4].value}   |"
        puts "       |______| |______| |______| |______| |______|"
        puts ""
        puts" ********************************************************** "
    end

    def scorebox(scorearr)
        puts "These are your possible score boxes"
        puts "(** means you have already scored that box)"
        puts "     ______________"
        puts "#1  |Ones__________| #{scorearr[0]}"
        puts "#2  |Twos__________| #{scorearr[1]}"
        puts "#3  |Threes________| #{scorearr[2]}"
        puts "#4  |Fours_________| #{scorearr[3]}"
        puts "#5  |Fives_________| #{scorearr[4]}"
        puts "#6  |Sixes_________| #{scorearr[5]}"
        puts "#7  |3 of a kind___| #{scorearr[6]}"
        puts "#8  |4 of a kind___| #{scorearr[7]}"
        puts "#9  |Full house____| #{scorearr[8]}"
        puts "#10 |Small straight| #{scorearr[9]}"
        puts "#11 |Large Straight| #{scorearr[10]}"
        puts "#12 |Chance________| #{scorearr[11]}"
        puts "#13 |Yahtzee_______| #{scorearr[12]}"
        puts ""
    end

    def getint
        begin
            var = Integer(gets)
            rescue ArgumentError
            puts "I'm sorry, that's not a valid input."
            puts "Which box do you want to score?"
            retry
        end
    end

end