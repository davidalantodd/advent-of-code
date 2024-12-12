file = open("data.txt")
file_data = file.read()

disk_map_dense = list(file_data)

disk_map = []

# expand disk map
for x, mem_location in enumerate(disk_map_dense):
    for i in range(0, int(mem_location)):
        if x % 2 == 0:  #file block
            disk_map += [str(int(int(x)/2))]
        else: # free space
            disk_map += ["."]

left_pointer = 0
right_pointer = len(disk_map) - 1


checked = []

# iterate starting with right-most file
while right_pointer >= 0:
    # check if we need to reset pointers
    if left_pointer >= right_pointer:
        right_pointer = right_pointer_beginning
        left_pointer = 0

    # set initial pointers
    while disk_map[left_pointer] != "." and left_pointer < len(disk_map) - 1:
        left_pointer += 1
    while disk_map[right_pointer] == ".":
        right_pointer -= 1
    
    right_pointer_beginning = right_pointer
    left_pointer_end = left_pointer

    # calculate pointers to map out size of free space and file size
    while len(disk_map) > left_pointer_end and disk_map[left_pointer_end] == ".":
        left_pointer_end += 1
    while disk_map[right_pointer_beginning] == disk_map[right_pointer]:
        right_pointer_beginning -= 1
    
    # calculate difference to compare
    right_pointer_diff = right_pointer - right_pointer_beginning
    left_pointer_diff = left_pointer_end - left_pointer

    # if there's enough room
    if right_pointer_diff <= left_pointer_diff and left_pointer < right_pointer:
        # check to be sure that a file hasn't already been moved
        if disk_map[right_pointer] not in checked:
            checked += [disk_map[right_pointer]]
            for i in range(0, right_pointer_diff):
                # swap all memory blocksin file because there is now room
                temp = disk_map[left_pointer + i]
                disk_map[left_pointer + i] = disk_map[right_pointer_beginning + 1 + i]
                disk_map[right_pointer_beginning + 1 + i] = temp
            left_pointer = 0
            right_pointer = right_pointer_beginning
    else:
        left_pointer += left_pointer_diff    
    
# calculate checksum
checksum = 0

for x, block in enumerate(disk_map):
   checksum += x * int(block) if block != "." else 0

print('part 2: ', checksum)
