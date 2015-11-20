module Parser

  class XMLBuilderEngine

    attr_reader :tag
    attr_reader :betweenTag
    attr_reader :ident
    attr_accessor :identIncrement

    public

      def initialize(pBaseSpaceIdent = 2)
        set_default(pBaseSpaceIdent)
      end

      def to_xml
        return @tag
      end

      def reset_engine
        @tag = nil
        set_default
      end

      def set_default(pBaseSpaceIdent = 2)
        @tag = '<?xml version="1.0" encoding="UTF-8"?>'
        @baseSpaceIdentation = pBaseSpaceIdent
        @content = ''
        @ident = ''
        @identIncrement = ' ' * pBaseSpaceIdent
      end

    private

      def method_missing(pTagName, *pTagParameters, &pBlock)
        @tag += "\n" unless @tag.strip == ''
        currentTagName = "#{@ident}<#{pTagName.to_s}"
        @tag << currentTagName

        if pTagParameters.size > 0 and pTagParameters[0].is_a? Hash
          handleArguments(pTagParameters)
        end

        if block_given?
          @tag << ">\n"
          incrementIdentation
          result = instance_eval(&pBlock)
          if result != '' && result.is_a?(String)
            updateTag(result)
          end

          decrementIdent
          @tag << "#{@ident}</#{pTagName.to_s}>\n"
          @tag.squeeze!("\n")
        else
          @tag << "/>\n"
        end
          @content = ''
      end

      def updateTag(pNewContent)
        @content = "\n#{@ident}" + pNewContent + "\n"
        @tag << @content
      end

      def handleArguments(pTagParameters)
        pTagParameters[0].each do |key, value|
          @tag << " #{key.to_s}=\"#{value.to_s}\""
        end
      end

      def incrementIdentation
        @ident += @identIncrement
      end

      def decrementIdent
        if @ident.size > 0
          @ident = @ident[0...(@ident.size - @baseSpaceIdentation)]
        end
      end

  end
end
