module Navigate

  class CdCommand

    public

      def initialize(pCodeNavigation)
        @codeNavigation = pCodeNavigation
      end

      def execute(pInput)
        pInput = handling_cd_input(pInput)
        puts pInput
        # Top level
        if pInput =~ /\.\./
          if @codeNavigation.depth > 0
            @codeNavigation.locationStack.pop
            @codeNavigation.depth = @codeNavigation.depth - 1
            handling_string(@codeNavigation.locationString)
          end
        end

        # First level
        if @codeNavigation.depth == 0
          first_level(pInput)
          return
        else
          # TODO: Future implementation, for going more deeply inside the 
          # structures. It means, going inside method or attribute list, ...
          puts "Sorry dude, you achieve the limit =("
        end

        puts ("No such file")
      end

    private

      def handling_cd_input(pInput)
        if pInput =~ /cd(.*)/
          prepare = pInput.scan(/cd(.*)/)
          pInput = prepare.join("").gsub(/\s+/, "")
          return pInput
        end
        return pInput
      end

      def handling_string(pLocation)
        pLocation = pLocation.gsub(/>.*>/,"")
        pLocation = pLocation + "> "
        pLocation.gsub!(/\s+/, " ")
        @codeNavigation.locationString = pLocation
      end

      def first_level(pInput)
        current = @codeNavigation.locationStack
        current.each do |element|
          if element.is_a?Languages::Language
            if element.get_name == pInput
              @codeNavigation.locationStack.push(element)
              @codeNavigation.locationString = 
                              @codeNavigation.locationString + " #{pInput} > "
              @codeNavigation.depth = @codeNavigation.depth + 1
              return
            end
          end
        end
      end

  # Class
  end

# Module
end 
