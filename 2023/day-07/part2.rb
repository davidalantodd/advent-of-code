class Hand
    attr_accessor :hand, :bid, :type, :rank, :card_strengths
    def initialize(hand, bid)
        @hand = hand
        @bid = bid
        @type = 0
        @rank = 0
        @card_strengths = []
    end
end

def solution

    file = File.read('data.txt').split("\n")

    hands = []

    file.each do |line|
        hand, bid = line.split(" ")
        hands.append(Hand.new(hand, bid.to_i))
    end

    # calculate type and strengths
    hands.each do |h|
        h.type = get_type(h)
        h.card_strengths = get_card_strengths(h)
        # p h
    end

    # sort hands by type, then by strengths
    hands.sort_by! { |a| [-a.type, a.card_strengths[0], a.card_strengths[1], a.card_strengths[2], a.card_strengths[3], a.card_strengths[4]] }

    # assign rank
    hands.each_with_index do |h, i|
        h.rank = i + 1
    end

    sum = 0
    hands.each { |h| sum += h.rank * h.bid }

    # hands.each { |h| p h }
    p 'part2: ' + sum.to_s
end

# calculate card strengths
def get_card_strengths(h)
    cards = {"A" => 14, "K" => 13, "Q" => 12, "J" => 1, "T" => 10, "9" => 9, "8" => 8, "7" => 7, "6" => 6, "5" => 5, "4" => 4, "3" => 3, "2" => 2}
    strengths = []

    h.hand.split("").each do |card|
        strengths.append(cards[card])
    end
    return strengths
end

# calculate type
def get_type(hand)
    types = {}
    hand.hand.split("").each do |card|
        if types[card] == nil
            types[card] = 1
        else
            types[card] += 1
        end
    end
    # part 2 - joker rule
    joker = false
    if types.keys.include?("J")
        joker = true
    end
    if (types.length == 1)
        # Five of a kind
        return 1 
    elsif (types.length == 2)
        if (joker == true)
            #upgrade to five of a kind
            return 1
        end
        if (types.values.include?(1))
            # Four of a kind
            return 2
        else
            # Full house
            return 3
        end
    elsif (types.length == 3)
        if (types.values.include?(3))
            if (joker == true)
                # upgrade to four of a kind
                return 2
            end
            # Three of a kind
            return 4
        else
            if (joker == true)
                if (types["J"] == 1)
                    # upgrade to full house
                    return 3
                else
                    # upgrade to four of a kind
                    return 2
                end
            end
            # Two pair
            return 5
        end
    elsif (types.length == 4)
        if (joker == true)
            # upgrade to three of a kind
            return 4
        end
        # One pair
        return 6
    else
        if (joker == true)
            # upgrade to one pair
            return 6
        end
        # High card
        return 7
    end
    return -1
end

solution