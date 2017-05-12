#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'basic_data'
require_relative 'function_data'
require_relative 'variable_global_data'
require_relative 'extern_requirement_data'
require_relative 'module_namespace_data'
require_relative 'class_data'

module Languages

  # FileElementData is the most important element related with container data,
  # this class refers to file. This class inherits from FunctionAbstract because
  # it behaves like a function when had to handle scripts
  class FileElementData < Languages::FunctionAbstract

    attr_reader :global_functions
    attr_reader :global_variables
    attr_reader :extern_requirements
    attr_reader :classes
    attr_reader :modules
    attr_reader :lines_of_code

    def initialize(pName)
      return nil if (pName.nil? || !pName.respond_to?(:to_str))
      super(pName)
      @global_functions = []
      @global_variables = []
      @extern_requirements = []
      @classes = []
      @modules = []
      @name = pName
      @comments = ''
      @lines_of_code = 0
    end

    def increase_loc
      @lines_of_code += 1
    end

    # Add global function to the file.
    # @param pFunction An object of FunctionData to be added at the file.
    def add_global_function(pFunction)
      return nil unless pFunction.is_a?(Languages::FunctionData)
      @global_functions.push(pFunction)
    end

    # Add global variable inside file.
    # @param pVariable A single VariableGlobalData object or list to be added.
    def add_global_variable(*pVariable)
      pVariable.flatten.each do |element|
        next unless element.is_a?(Languages::VariableGlobalData)
        @global_variables.push(element)
      end
    end

    # Add extern requirement inside file.
    # @param pOutside Add an object of ExternRequirementData.
    def add_extern_requirement(pOutside)
      return nil unless pOutside.is_a?(Languages::ExternRequirementData)
      @extern_requirements.push(pOutside)
    end

    # Add a class inside file.
    # @param pClass Add an object of ClassData.
    def add_class(pClass)
      return nil unless pClass.is_a?(Languages::ClassData)
      @classes.push(pClass)
    end

    # Add a module inside file.
    # @param pModule Add an object of ModuleNamespaceData
    def add_modules(pModule)
      return nil unless pModule.is_a?(Languages::ModuleNamespaceData)
      @modules.push(pModule)
    end

    # Add attribute to class
    # @param pAttributeElement Add an attribute to the last class
    def add_attribute_to_last_class(pAttributeElement)
      classes.last.add_attribute(pAttributeElement)
    end

    # Get index from the last class.
    # @return Integer representing the last index from classes.
    def get_last_class_index
      return classes.length - 1
    end
  end # Class
end # Module
