# Class Setting that read and handle .kuniri file
class Setting
	attr_reader :wiki, :source, :output, :extract

	def initialize(filePath = ".kuniri")
		lines = File.open(filePath).read
		lines.gsub!(/\r\n?/, "\n")
		#set the strings
	end


	# Get the line, and split it by ':'.
	#
	# @param world [String] Line read from the file, and with the syntax.
	# @return [String] Return a string after ':'
	def getSecondPart (world)
		divided = line.split(/:/)[1]
		if divided == nil or divided.size > 3
			#raise "Sintax error"
		end
		return divided[1]
	end

	private
	def setWiki(line)
		wikiTmp = getSecondPart(line)
		self.wiki = wikiTmp
	end

	def setSource(line)
		sourceTmp = getSecondPart(line)
		self.source = sourceTmp
	end

	def setOutput(line)
		outputTmp = getSecondPart(line)
		self.output = outputTmp
	end

	def setExtract(line)
		extractTmp = getSecondPart(line)
		self.extract = extractTmp
	end 
end
