class Player

    attr_reader :scorecard, :total_score, :name

    def initialize(name)
        @name = name
        @scorecard = {   ones: 0, twos: 0, threes: 0, fours: 0, fives: 0, sixes: 0,
            threeofakind: 0, fourofakind: 0, fullhouse: 0, smstraight: 0, lgstraight: 0,
            chance: 0, yahtzee: 0
        }
        @yahtzeecount = 0
    end

    def total_score
        @total_score = @scorecard.values.reduce(:+)
        if lower_score >= 63
            @total_score += 35
        end
        return @total_score
    end

    def lower_score
        @lower_score = @scorecard[:ones] + @scorecard[:twos] + @scorecard[:threes] + @scorecard[:fours] + @scorecard[:fives] + @scorecard[:sixes]
    end

    def score(dice_set)

        @scorecard[:ones] > 1 ?         ones = "#{@scorecard[:ones]}**" : ones = ones(dice_set)
        @scorecard[:twos] > 1 ?         twos = "#{@scorecard[:twos]}**" : twos = twos(dice_set)
        @scorecard[:threes] > 1 ?       threes = "#{@scorecard[:threes]}**" : threes = threes(dice_set)
        @scorecard[:fours] > 1 ?        fours = "#{@scorecard[:fours]}**" : fours = fours(dice_set)
        @scorecard[:fives] > 1 ?        fives = "#{@scorecard[:fives]}**" : fives = fives(dice_set)
        @scorecard[:sixes] > 1 ?        sixes = "#{@scorecard[:sixes]}**" : sixes = sixes(dice_set)
        @scorecard[:threeofakind] > 1 ? threeofakind = "#{@scorecard[:threeofakind]}**" : threeofakind = threeofakind(dice_set)
        @scorecard[:fourofakind] > 1 ?  fourofakind = "#{@scorecard[:fourofakind]}**" : fourofakind = fourofakind(dice_set)
        @scorecard[:fullhouse] > 1 ?    fullhouse = "#{@scorecard[:fullhouse]}**" : fullhouse = fullhouse(dice_set)
        @scorecard[:smstraight] > 1 ?   smstraight = "#{@scorecard[:smstraight]}**" : smstraight = smstraight(dice_set)
        @scorecard[:lgstraight] > 1 ?   lgstraight = "#{@scorecard[:lgstraight]}**" : lgstraight = lgstraight(dice_set)
        @scorecard[:chance] > 1 ?       chance = "#{@scorecard[:chance]}**" : chance = chance(dice_set)
        yahtzee = yahtzee(dice_set)
        if @scorecard[:yahtzee] > 1 && yahzee == 0
            yahtzee = "#{@scorecard[:yahtzee]}**"
        else 
            yahtzee = @scorecard[:yahtzee] + yahtzee(dice_set)
        end

        return scorearray = [ones,twos,threes,fours,fives,sixes,threeofakind,fourofakind,fullhouse,smstraight,lgstraight,chance,yahtzee]
        
    end

    def update_score(scorearr,index)
        symbol = @scorecard.flatten[(index + index)]
        @scorecard[symbol] = scorearr[index]
    end

    def current_scorecard
        puts "     ______________"
        puts "#1  |Ones__________| #{@scorecard[:ones]}"
        puts "#2  |Twos__________| #{@scorecard[:twos]}"
        puts "#3  |Threes________| #{@scorecard[:threes]}"
        puts "#4  |Fours_________| #{@scorecard[:fours]}"
        puts "#5  |Fives_________| #{@scorecard[:fives]}"
        puts "#6  |Sixes_________| #{@scorecard[:sixes]}"
        puts "#7  |3 of a kind___| #{@scorecard[:threeofakind]}"
        puts "#8  |4 of a kind___| #{@scorecard[:fourofakind]}"
        puts "#9  |Full house____| #{@scorecard[:fullhouse]}"
        puts "#10 |Small straight| #{@scorecard[:smstraight]}"
        puts "#11 |Large Straight| #{@scorecard[:lgstraight]}"
        puts "#12 |Chance________| #{@scorecard[:chance]}"
        puts "#13 |Yahtzee_______| #{@scorecard[:yahtzee]}"
        puts ""
    end

    private

    def ones(dice_set)
        ones = 0
        dice_set.each {|x| x == 1 ? ones +=1 : nil }
        return ones
    end
    
    def twos(dice_set)
        twos = 0
        dice_set.each {|x| x == 2 ? twos +=2 : nil }
        return twos
    end

    def threes(dice_set)
        threes = 0
        dice_set.each {|x| x == 3 ? threes +=3 : nil }
        return threes
    end

    def fours(dice_set)
        fours = 0
        dice_set.each {|x| x == 4 ? fours +=4 : nil }
        return fours
    end

    def fives(dice_set)
        fives = 0
        dice_set.each {|x| x == 5 ? fives +=5 : nil }
        return fives
    end
    
    def sixes(dice_set)
        sixes = 0
        dice_set.each {|x| x == 6 ? sixes +=6 : nil }
        return sixes
    end

    def threeofakind(dice_set)
        threeofakind = 0
        dice_set.each do |x|
            if dice_set.count(x) == 3
                threeofakind = dice_set.reduce(:+)
            end
        end
        return threeofakind
    end


    def fourofakind(dice_set)
        fourofakind = 0
        dice_set.each do |x|
            if dice_set.count(x) == 4
                fourofakind = dice_set.reduce(:+)
            end
        end
        return fourofakind
    end

    def fullhouse(dice_set)
        fullhouse = 0
        second = dice_set.select{|y| dice_set.count(y) == 3 || dice_set.count(y) == 2}
        if second.size == 5
            fullhouse = 25
        end
        return fullhouse
    end

    def smstraight(dice_set)
        smstraight = 0
        running = true
        dice_set.uniq.sort.each_cons(4) do |arr|
            if arr[0] == (arr [1] - 1) && arr[1] == (arr [2] - 1) && arr[2] == (arr [3] - 1)
                while running
                    smstraight = 30
                    running = false
                end
            end
        end
        return smstraight
    end

    def lgstraight(dice_set)
        lgstraight = 0
        running = true
        dice_set.sort.each_cons(5) do |arr|
            if arr[0] == (arr [1] - 1) && arr[1] == (arr [2] - 1) && arr[2] == (arr [3] - 1) && arr[3] == (arr [4] - 1)
                while running
                    lgstraight = 40
                    running = false
                end
            end
        end
        return lgstraight
    end

    def yahtzee(dice_set)
        yahtzee = 0
        running = true
        if @yahtzeecount >= 1
            yahtzee = 50 + (100 * @yahtzeecount)
        else
            dice_set.each do |x|
                if dice_set.count(x) == 5
                    while running
                        yahtzee = 50
                        @yahtzeecount += 1
                        running = false
                    end
                end
            end
        end
        return yahtzee
    end

    def chance(dice_set)
        chance = 0 
        chance = dice_set.reduce(:+)
        return chance
    end

end

# scorearray.each do |x|
#     @scorecard[x.to_sym] = x
# end