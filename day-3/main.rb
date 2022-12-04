# file = File.open('example.txt')
# file_data = file.read
# file.close

#initilize variables
priority_sum = 0
similar = ''

# read file and loop through each line
File.foreach("data.txt") {
    |line|

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

puts priority_sum




