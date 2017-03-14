def lines_to_fields(lines)
  y = nil
  fields = []
  field = nil

  lines.each do |line|
    if y.nil? or y == field.length
      raise "Invalid input: Expected W L" unless line =~ /^(\d+) (\d+)$/
      break if $1.to_i == 0 and $2.to_i == 0
      field = MineField.new($2.to_i, $1.to_i)
      fields.push(field)
      y = 0
    else
      (0..field.width-1).each do |x|
        if line[x] == '*'
          field.drop_mine(Coord.new(x, y))
        end
      end
      y += 1
    end
  end

  fields
end
