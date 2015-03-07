# Module responsible for handling the code navigation.
module Navigate

  # Class responsible for handling the navigation mode under the code.
  class CodeNavigate

    public

      # @param [list] Receives a list with object files.
      def initialize(pFiles = [])
        @filesToNavigate = pFiles
        @currentStage = pFiles
        @languageClass = false
      end

      # Navigate under the previously parsed code. You can use commands similar
      # to bash to navigate under the code.
      def navigate_mode

        while true
          print ">: "
          input = gets
          input = handling_row_input(input)

          if input =~ /exit/
            exit_command(input)
            break
          elsif input =~ /cd/
            cd_command(input)
          elsif input =~ /ls/
            ls_command(input)
          else
            next
          end

        # While
        end
      end

    private

      @filesToNavigate
      @currentStage
      @languageClass

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
        unless @languageClass
          @currentStage.each do |languageObject|
            if languageObject.get_name == pInput
              @currentStage = languageObject
              @languageClass = true
              puts ("enter into: #{pInput}")
              return
            end 
          end
          puts ("#{pInput} looks wrong...")
          return
        else
          puts "Sorry dude, :( \n not implemented yet..."
        end

        #if pInput =~ /../
        #  ... up one level again... 
        #end
      end

      def ls_command(pInput)
        count = 0

        unless @languageClass
          @currentStage.each do |file|
            puts "\t[#{count}] #{file.get_name}"
            count = count + 1
          end
        else
          puts "I'm inside of the language class..."
        end

      end

      def exit_command(pInput)
        puts "exit"
      end

  # Class
  end

# Module
end
