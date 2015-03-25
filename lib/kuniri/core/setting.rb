# Class Setting that read and handle .kuniri file
class Setting

  attr_reader :wiki, :source, :output, :extract

  def initialize(pFilePath = ".kuniri")
    lines = File.open(pFilePath).read
    lines.gsub!(/\r\n?/, "\n")
    #set the strings
  end

  # Get the line, and split it by ':'.
  # @param world [String] Line read from the file, and with the syntax.
  # @return [String] Return a string after ':'
  def get_second_part(pWorld)
    divided = line.split(/:/)[1]
      if divided == nil or divided.size > 3
        #raise "Sintax error"
      end

      return divided[1]
  end

  private

    def set_wiki(pLine)
      wikiTmp = get_second_part(pLine)
      self.wiki = wikiTmp
    end

    def set_source(pLine)
      sourceTmp = get_second_part(pLine)
      self.source = sourceTmp
    end

    def set_output(pLine)
      outputTmp = get_second_part(pLine)
      self.output = outputTmp
    end

    def set_extract(pLine)
      extractTmp = get_second_part(pLine)
      self.extract = extractTmp
    end
end
