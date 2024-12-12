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

while left_pointer < right_pointer:
    # set initial pointers
    while disk_map[left_pointer] != ".":
        left_pointer += 1
    while disk_map[right_pointer] == ".":
        right_pointer -= 1
    
    # swap memory blocks if room
    temp = disk_map[left_pointer]
    disk_map[left_pointer] = disk_map[right_pointer]
    disk_map[right_pointer] = temp
    left_pointer += 1
    right_pointer -= 1

# calculate checksum
checksum = 0

for x, block in enumerate(disk_map):
   checksum += x * int(block) if block != "." else 0

print('part 1: ', checksum)