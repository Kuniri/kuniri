module Navigate

  class LsCommand

    public

      def initialize(pCodeNavigation)
        @codeNavigation = pCodeNavigation
      end

      def execute(pInput)
        count = 0

        unless @codeNavigation.depth > 0
          @codeNavigation.locationStack.each do |file|
            puts "[#{count}] #{file.get_name}"
            count = count + 1
          end
        else
          current = @codeNavigation.locationStack.last
          pInput = handling_ls_command(pInput)
          if pInput == "-a"
            attributeList = current.attribute_extract
            attributeList.each do |attribute|
              puts " #{attribute.name}"
            end
          elsif pInput == "-m"
            methodList = current.method_extract
            methodList.each do |method|
              puts " #{method.name}"
            end
          end
        end
      end

    private

      def handling_ls_command(pInput)
        return pInput.scan(/-a|-m|-c/).join("") if pInput =~ /-a|-m|-c/
        return pInput
      end

  # Class
  end

# Module
end
