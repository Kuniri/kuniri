require_relative 'ls_command'
require_relative 'cd_command'

# Module responsible for handling the code navigation.
module Navigate

  # Class responsible for handling the navigation mode under the code.
  class CodeNavigate

    public

      # @param [list] Receives a list with object files.
      def initialize(pFiles = [])
        @location = "File List > "
        @locationStack = pFiles
        @depth = 0
        @lsCommand = Navigate::LsCommand.new
        @cdCommand = Navigate::CdCommand.new
      end

      # Navigate under the previously parsed code. You can use commands similar
      # to bash to navigate under the code.
      def navigate_mode

        while true
          print @location
          input = gets
          input = handling_row_input(input)

          if input =~ /exit/
            exit_command(input)
            break
          elsif input =~ /cd/
            @depth, @location, @locationStack = 
                @cdCommand.execute(input, @depth, @locationStack, @location)
          elsif input =~ /ls/
            @lsCommand.execute(input, @depth, @locationStack)
          else
            next
          end

        # While
        end
      end

    private

      @location
      @locationStack
      @depth

      def handling_row_input(pInput)
        pInput.lstrip!
        pInput.rstrip!
        pInput.gsub!(/\s+/, " ") if pInput =~ /\s+/
        return pInput
      end

      def handling_cd_input(pInput)
        if pInput =~ /cd(.*)/
          prepare = pInput.scan(/cd(.*)/)
          pInput = prepare.join("").gsub(/\s+/, "")
          return pInput
        end
        return pInput
      end

      def cd_command(pInput)
        pInput = handling_cd_input(pInput)
        # Top level
        if pInput =~ /\.\./
          if @depth > 0
            @locationStack.pop
            @depth = @depth - 1
            @location = @location.gsub(/>.*>/,"")
            @location = @location + "> "
            @location.gsub!(/\s+/, " ")
          end
          return
        end

        # First level
        if @depth == 0
          current = @locationStack
          current.each do |element|
            if element.is_a?Languages::Language
              if element.get_name == pInput
                @locationStack.push(element)
                @location = @location + " #{pInput} > "
                @depth = @depth + 1
                return
              end
            end
          end
        else
          # TODO: Future implementation, for going more deeply inside the 
          # structures. It means, going inside method or attribute list, ...
          puts "Sorry dude, you achieve the limit =("
        end

        puts ("No such file")
        return
      end

      def exit_command(pInput)
        puts "Bye bye kuniri =)"
      end

  # Class
  end

# Module
end
