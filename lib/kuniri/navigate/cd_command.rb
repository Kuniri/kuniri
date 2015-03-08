module Navigate

  class CdCommand

    public

      def execute(pInput, pDepth, pLocationStack, pLocation)
        pInput = handling_cd_input(pInput)
        puts pInput
        # Top level
        if pInput =~ /\.\./
          if pDepth > 0
            pLocationStack.pop
            pDepth = pDepth - 1
            pLocation = pLocation.gsub(/>.*>/,"")
            pLocation = pLocation + "> "
            pLocation.gsub!(/\s+/, " ")
          end
          return pDepth, pLocation, pLocationStack
        end

        # First level
        if pDepth == 0
          current = pLocationStack
          current.each do |element|
            if element.is_a?Languages::Language
              if element.get_name == pInput
                pLocationStack.push(element)
                pLocation = pLocation + " #{pInput} > "
                pDepth = pDepth + 1
                return pDepth, pLocation, pLocationStack
              end
            end
          end
        else
          # TODO: Future implementation, for going more deeply inside the 
          # structures. It means, going inside method or attribute list, ...
          puts "Sorry dude, you achieve the limit =("
        end

        puts ("No such file")
        return pDepth, pLocation, pLocationStack
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

  # Class
  end

# Module
end 
