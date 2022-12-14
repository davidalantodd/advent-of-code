# file = File.open('example.txt')
# file_data = file.read
# file.close

#initilize variables
priority_sum = 0
similar = ''
lines = Array.new

# read file and loop through each line
File.foreach("data.txt") {
    |line|

    #store lines in array for part 2, remove \n char
    lines << line[0,line.length-1]

    #split into two rucksacks/strings
    len = line.length
    rucksack1 = line[0,len/2]
    rucksack2 = line[len/2, len]
    
    #iterate through each char in r1, check if it's in r2
    rucksack1.each_char{
        |char|
        if rucksack2.include?(char)
            similar = char
        end
    }
    #convert char to ASCII, adjust to priority num, add to sum
    similar.downcase == similar ?
        (priority_sum += similar.ord - 96) :
        (priority_sum += similar.ord - 38)
}

#part 2 -- iterate through each line in sets of 3 to compare for similar value
#new variables
badge = ''
badge_sum = 0

lines.each_slice(3){
    |elf1, elf2, elf3|
    elf1.each_char{
        |letter|
        if (elf2.include?(letter) && elf3.include?(letter))
            badge = letter
        end
    }
    badge.downcase == badge ?
        (badge_sum += badge.ord - 96) :
        (badge_sum += badge.ord - 38)
}

puts "Part 1 sum: " + String(priority_sum)
puts "Part 2 sum: " + String(badge_sum)



