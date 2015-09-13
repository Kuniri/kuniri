module Parser

  class OutputFormat

    public

      def create_data(pParser)
        raise NotImplementedError
      end

      def class_generate(pClass)
        raise NotImplementedError
      end

      def constructor_generate(pConstructor)
        raise NotImplementedError
      end

      def inheritance_generate(pInheritance)
        raise NotImplementedError
      end

      def method_generate(pMethod)
        raise NotImplementedError
      end

      def parameters_generate(pParameters)
        raise NotImplementedError
      end

      def attribute_generate(pAttribute)
        raise NotImplementedError
      end

      def function_generate(pFunction)
        raise NotImplementedError
      end

      def global_variable_generate(pGlobalVariable)
        raise NotImplementedError
      end

      def require_generate(pRequire)
        raise NotImplementedError
      end

      def repetition_generate(pRepetition)
        raise NotImplementedError
      end

      def conditional_generate(pConditional)
        raise NotImplementedError
      end

  # class
  end

# module
end
