# Class Setting that read and handle .kuniri file
class Setting

  attr_reader :wiki, :source, :output, :extract

  def initialize(filePath = ".kuniri")
    lines = File.open(filePath).read
    lines.gsub!(/\r\n?/, "\n")
    #set the strings
  end

  # Get the line, and split it by ':'.
  # @param world [String] Line read from the file, and with the syntax.
  # @return [String] Return a string after ':'
  def get_second_part(world)
    divided = line.split(/:/)[1]
      if divided == nil or divided.size > 3
        #raise "Sintax error"
      end

      return divided[1]
  end

  private

  def set_wiki(line)
    wikiTmp = get_second_part(line)
    self.wiki = wikiTmp
  end

  def set_source(line)
    sourceTmp = get_second_part(line)
    self.source = sourceTmp
  end

  def set_output(line)
    outputTmp = get_second_part(line)
    self.output = outputTmp
  end

  def set_extract(line)
    extractTmp = get_second_part(line)
    self.extract = extractTmp
  end
end
