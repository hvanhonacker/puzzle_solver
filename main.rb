def gen_solve(map_size, pieces, max_attempts = 1000)
  t = Time.now
  found = false
  i = 0
  while i < max_attempts && !found
    i += 1
    pieces = pieces.shuffle
    map = gen_map(map_size)
    found, map = solve(gen_map(map_size), pieces, [0,0])
  end

  puts "Attempts: #{i}"
  puts "Time: #{Time.now - t} sec"

  if found
    puts "Solution found !"
    print_map map
  else
    puts "Solution not found :/"
  end
end

def solved?(map)
  map.flatten.none? {|p| !p }
end

def solve(map, pieces, cur_pos)
  return solved?(map), map unless cur_pos && pieces.any?
  if put_piece(map, pieces.first, cur_pos)
    solve(map, pieces[1..-1], [0, 0])
  else
    solve(map, pieces, next_pos(cur_pos, map))
  end
end

def put_piece(map, piece, pos)
  marker = (('a'..'z').to_a + ('A'..'Z').to_a - map.flatten.uniq).shuffle.first
  if piece_fits?(map, piece, pos)
    piece.each do |p|
      map[pos[0] + p[0]][pos[1] + p[1]] = marker
    end
    true
  else
    false
  end
end

def piece_fits?(map, piece, pos)
  x_max = x_max(map)
  y_max = y_max(map)

  x_offset = pos[0]
  y_offset = pos[1]

  piece.all? {|p| (x_offset + p[0]) <= x_max && (y_offset + p[1]) <= y_max && map[x_offset + p[0]][y_offset + p[1]] == false}
end

def next_pos(pos, map)
  x = pos[0] + 1
  y = pos[1]

  if x > x_max(map)
    x = 0
    y += 1
  end

  if y > y_max(map)
    nil
  else
    [x, y]
  end
end

def x_max(map)
  r=map.first.size - 1
end

def y_max(map)
 r= map.size - 1
end

def gen_map(n)
  map = []
  n.times do
    l = []
    n.times do
      l << false
    end
    map << l
  end
  map
end

def print_piece piece
  map = gen_map(piece.flatten.max+1)
  put_piece(map, piece, [0,0])
  map.each do |l|
    puts l.join ''
  end
end

def print_map map
  map.each do |l|
    puts l.map {|c| c ? c : ' '}.join ''
  end
  puts ''
end

p1=[[0,0],[0,1],
    [1,0],[1,1]]

p2=[[0,0],
    [1,0]]

p3=[[0,0],
    [1,0]]

p4=[[0,0],[0,1]]

p5=[[0,0],[0,1]]

p6=[[0,0],[0,1]]

p7=[[0,0],[0,1]]

p8=[[0,0],[0,1],
    [1,0]]

p9=[      [0,1],
    [1,0],[1,1]]

p10=[[0,0]]
p11=[[0,0]]
p12=[[0,0]]

pieces = [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12]

map_size = 5

gen_solve(map_size, pieces, 1000000)


# p1=[      [0,1],
#     [1,0],[1,1],[1,2],
#     [2,0],[2,1],[2,2]]

# p2=[[0,0],[0,1],[0,2],[0,3],
#     [1,0],[1,1],[1,2],
#     [2,0],[2,1]]

# p3=[[0,0],[0,1],
#     [1,0],[1,1],
#     [2,0],[2,1],
#     [3,0]]

# p4=[[0,0],[0,1],[0,2],
#     [1,0],[1,1],
#     [2,0]]

# p5=[[0,0],[0,1],[0,2],[0,3],
#     [1,0],[1,1],[1,2],[1,3],
#     [2,0],[2,1]]

# p6=[[0,0],[0,1],[0,2],[0,3],
#     [1,0],[1,1],[1,2],[1,3],
#     [2,0],[2,1],[2,2],[2,3]]

# p7=[[0,0],[0,1],
#     [1,0],[1,1],
#     [2,0],[2,1]]

# p8=[      [0,1],[0,2],
#     [1,0],[1,1],[1,2],
#     [2,0],[2,1],[2,2]]

# p9=[            [0,2],
#           [1,1],[1,2],
#     [2,0],[2,1],[2,2]]

# p10=[[0,0],[0,1],[0,2],
#      [1,0],[1,1]]

# p11=[[0,0],[0,1],
#      [1,0],[1,1],[1,2],[1,3],
#            [2,1],[2,2],[2,3]]

# p12=[[0,0],[0,1],
#      [1,0],[1,1],
#      [2,0],[2,1],
#      [3,0],[3,1]]

# p13=[     [0,1],
#     [1,0],[1,1],[1,2],[1,3],[1,4]]

# pieces = [p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, p11, p12, p13]

# map_size = 10

# #gen_solve(map_size, pieces, 10000)

# def fac(n)
#   return 1 if n == 0
#   n * fac(n-1)
# end

# puts fac(12)

