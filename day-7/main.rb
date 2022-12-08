data = File.read("data.txt").split("\n")

class Directory
    attr_accessor :name, :files, :directories, :up
 
    def initialize(dir_name, fs, dirs, up)
        @name = dir_name
        @files = fs
        @directories = dirs
        @up = nil
    end

end

# testing Directory file structure
# file_system = Directory.new("/", Hash["b.txt" => 14848514, "c.dat" => 8504156], Hash["a" => nil, "d" => nil])
# file_system.insert_data("a", Hash["h.lst" => 62596, "f" => 29116, "g" => 2557], Hash["e" => nil])

i = 0
file_system = nil
current = nil
how_many = 0
nilnum = 0
dir_names = []
while i < data.length do
    # p "              command"
    # p data[i]
    if data[i][0] == "$"
        #handles commands starting with $ 
        if data[i][0..5] == "$ cd /"
            #initializes entire file system
            file_system = Directory.new("/", Hash[], Hash[], nil)
            current = file_system
            how_many+=1
            dir_names << "/"
        elsif data[i][0..3] == "$ ls"
            #signals list command
            p "reading data"
        elsif data[i][0..6] == "$ cd .."
            #handles change directory upward
            p "changing directory a level up .."
            current = current.up
        elsif data[i][0..3] == "$ cd"
            #handles change directory downward
            cd_data = data[i].split(" ")
            p "changing directory into " + cd_data[2]
            temp_up = current
            current = current.directories[cd_data[2]]
            current.up = temp_up
        end
    else
        #handles reading file and directory names
        if data[i][0..2] == "dir"
            #reading directories by creating a directory and contents (empty dir and file Hashes)
            dir_name_from_cl = data[i].split(" ")
            if current.directories[dir_name_from_cl[1]] == nil then
                full_dir_name = current.name + "/" + dir_name_from_cl[1]
                current.directories[dir_name_from_cl[1]] = Directory.new(full_dir_name, Hash[], Hash[], current)
            end
            how_many+=1
            dir_names << dir_name_from_cl[1]
        elsif
            #reading file by creating new file within Hash
            file_name_from_cl = data[i].split(" ")
            current.files[file_name_from_cl[1]] = file_name_from_cl[0]
        end
    end
    i = i+1
end

#part 1 computation
@directory_totals = Hash[]
def FindTotals(current_directory)
    if current_directory.files == {}
        #iterate through directories 
        current_directory.directories.each do |dir_name, dir|
            FindTotals(current_directory.directories[dir_name])
        end
    elsif
        temp_total = current_directory.files.inject(0) {|sum, files|
            sum += Integer(files[1]).dup
        }
        @directory_totals[current_directory.name] == nil ?
            (@directory_totals[current_directory.name] = temp_total) :
            (@directory_totals[current_directory.name] += (temp_total))
        going_up = current_directory.up
        #loops back up the directory path to add this total any directories including this one
        while going_up != nil do
            @directory_totals[going_up.name] == nil ?
            (@directory_totals[going_up.name] = temp_total) :
            (@directory_totals[going_up.name] += (temp_total))
            going_up = going_up.up
        end
        if current_directory.directories != {} 
            #iterate through the directories to search for more totals
            current_directory.directories.each do |dir_name, dir|
                FindTotals(current_directory.directories[dir_name])
            end
        end
    end
end

p FindTotals(file_system)

part1_sum = 0

p file_system

#sum up all total sizes
@directory_totals.each do |dir_name, totals|
    if @directory_totals[dir_name] <= 100000
        part1_sum += @directory_totals[dir_name].dup
    end
end

p @directory_totals


#part 2 -- delete to make room
p total_disk = 70000000
p needed_space = 30000000

#calculate space needed
unused_space = (total_disk - @directory_totals["/"])
difference_to_make = needed_space - unused_space
p difference_to_make

delete_options = []

#find all directories with appropriate size
@directory_totals.each do |dir_name, totals|
    if @directory_totals[dir_name] >= 4274331
        delete_options << @directory_totals[dir_name]
    end
end

#sort to find smallest
delete_options.sort!

puts "\n" + "part 1 solution: " + part1_sum.to_s
puts "part 2 solution: " + String(delete_options[0])