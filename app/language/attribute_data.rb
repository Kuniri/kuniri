require_relative 'basic_data'

# 
module Languages
  # 
  class AttributeData < Languages::BasicData
    
    public
      def initialize (attribute_name)
        name = attribute_name
      end

    private
      @type

  end
end
