file = open("data.txt", "r")
file_data = file.read()
lines = file_data.splitlines()

fully_contained_pairs = 0
overlapping_at_all = 0

for pair in lines: 
    #format line to grab section assignments into pairs
    both = pair.split(',')
    first_pair = both[0].split('-')
    second_pair = both[1].split('-')

    #check if numbers overlap by casting to integer and comparing the ranges
    if int(first_pair[0]) <= int(second_pair[0]) and int(first_pair[1]) >= int(second_pair[1]):
        fully_contained_pairs += 1
    elif int(first_pair[0]) >= int(second_pair[0]) and int(first_pair[1]) <= int(second_pair[1]):
        fully_contained_pairs += 1

    #part 2 checks - first check if either have a match
    if int(first_pair[0]) == int(second_pair[0]) or int(first_pair[1]) == int(second_pair[1]) \
        or int(first_pair[0]) == int(second_pair[1]) or int(first_pair[1]) == int(second_pair[0]):
        overlapping_at_all += 1
    # check if the ranges overlap in one direction
    elif (int(second_pair[0]) - int(first_pair[1]) > 0) and (int(second_pair[1]) - int(first_pair[0]) < 0):
        overlapping_at_all += 1
    #check if ranges overlap in the other direction
    elif (int(second_pair[0]) - int(first_pair[1]) < 0) and (int(second_pair[1]) - int(first_pair[0]) > 0):
        overlapping_at_all += 1

print("part 1: " + str(fully_contained_pairs))
print("part 2: " + str(overlapping_at_all))
