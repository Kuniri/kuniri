class SimpleBlocks

  def analyse_first_step(pPath)
    fileElement = Languages::FileElementData.new(pPath)
    @source = File.open(pPath, "rb")
    @source.each do |line|
      next if line.gsub(/\s+/,"").size == 0
      processedLines = handle_semicolon(line)
      if !processedLines.nil?
        processedLines.each do |line|
          @state.handle_line(line)
          fileElement = @state.execute(fileElement, line)
        end
      end
  end

  def first
    u = [1, 2, 3, 4, 5]
    u.each do |x|
      puts "#{x} values"
    end
  end

  def second
    x = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    x.each do |theValue|
      if theValue == 3
        puts "3"
      end
    end

    x.map do |ahhhh|
      ahhhh = ahhhh + 3
    end
  end

end
