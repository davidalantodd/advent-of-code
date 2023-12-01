data = File.read("data.txt").split("\n")

col = data.length
row = data[0].length

grid = Array.new(col)
directions = Array.new(col)

#create grid
row.times do |r_index|
    grid[r_index] = Array.new(col)
    directions[r_index] = Array.new(col)
    col.times do |c_index|
        grid[r_index][c_index] = data[r_index][c_index]
        directions[r_index][c_index] = ""
    end
end

num_visible = 0
scenic_score = 0

#traverse grid
row.times do |r|
    col.times do |c|
        visible = ""
        temp_pos = [r, c]
        temp_scenic = 0

        #traverse left
        left = true
        num_trees_L = 0
        temp_c = c.dup-1
        while temp_c >= 0 do
            num_trees_L+=1
            if grid[r][c] <= grid[r][temp_c]
                left = false
                break
            end
            temp_c-=1
        end

        #traverse right
        right = true
        num_trees_R = 0
        temp_c = c.dup+1
        while temp_c < col do
            num_trees_R+=1
            if grid[r][c] <= grid[r][temp_c]
                right = false
                break
            end
            temp_c+=1
        end

        #traverse up
        up = true
        num_trees_U = 0
        temp_r = r.dup-1
        while temp_r >= 0 do
            num_trees_U+=1
            if grid[r][c] <= grid[temp_r][c]
                up = false
                break
            end
            temp_r-=1
        end

        #traverse down
        down = true
        num_trees_D = 0
        temp_r = r.dup+1
        while temp_r < row do
            num_trees_D+=1
            if grid[r][c] <= grid[temp_r][c]
                down = false
                break
            end
            temp_r+=1
        end

        #track the directions
        if left then
            directions[r][c] += "L"
        end
        if right then
            directions[r][c] += "R"
        end
        if up then
            directions[r][c] += "U"
        end
        if down then
            directions[r][c] += "D"
        end

        #increase visible count if visible from edge
        if directions[r][c] != "" then num_visible += 1 end

        #calc scenic score and set it if highest so far
        temp_scenic = num_trees_L * num_trees_R * num_trees_U * num_trees_D
        if temp_scenic > scenic_score then scenic_score = temp_scenic end

    end
end

# p grid
# p directions

p "solution for part 1: " + String(num_visible)
p "solution for part 2: " + String(scenic_score)
