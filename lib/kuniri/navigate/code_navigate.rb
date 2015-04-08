require_relative 'ls_command'
require_relative 'cd_command'

# Module responsible for handling the code navigation.
module Navigate

  # Class responsible for handling the navigation mode under the code.
  class CodeNavigate

    public

      attr_accessor :locationStack
      attr_accessor :depth
      attr_accessor :locationString

      # @param [list] Receives a list with object files.
      def initialize(pFiles = [])
        @locationString = "File List > "
        @locationStack = pFiles
        @depth = 0
        @lsCommand = Navigate::LsCommand.new(self)
        @cdCommand = Navigate::CdCommand.new(self)
      end

      # Navigate under the previously parsed code. You can use commands similar
      # to bash to navigate under the code.
      def navigate_mode

        while true
          print @locationString
          input = gets
          input = handling_row_input(input)

          if input =~ /^\s+exit|^exit/
            puts "Bye bye kuniri =)"
            break
          elsif input =~ /cd/
            @cdCommand.execute(input)
          elsif input =~ /ls/
            @lsCommand.execute(input)
          else
            next
          end

        # While
        end
      end

    private

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

  # Class
  end

# Module
end
