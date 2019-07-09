# Edit these
FILES      = %w{narcotics no_narcotics}
WIDTH      =  5.0 # cm
RANGE      =  500
POINT_SIZE = 0.07 # cm

# Don't edit these
SCALE  = WIDTH.to_f / RANGE.to_f
RADIUS = (POINT_SIZE.to_f / SCALE.to_f).round.to_i

record Point, x : Int32, y : Int32

def abs(num)
  if num < 0
    return -num
  end

  num
end

def main
  FILES.each do |f|
    content = File.read("./#{f}.arr")

    xy_content = parse f, content

    File.open("./#{f}.table", "w") do |f|
      f.puts "x y"
      xy_content.each do |point|
        f.puts "#{point.x} #{point.y}"
      end
    end
  end
end

def parse(name, file)
  puts "\nParsing #{name}..."

  lines = file.split
  arr_x = lines.reduce([] of Int32) do |arr, item|
    next arr unless item.to_i?
    num = (item.to_i.to_f / RADIUS.to_f).round.to_i * RADIUS

    arr + [num]
  end

  arr_x.reduce([] of Point) do |points, item|
    y = points.reduce(0) do |num, p|
      if p.x == item
        num + 1
      else
        num
      end
    end

    points + [Point.new(item, y)]
  end
end

main
