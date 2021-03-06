#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

require_relative 'basic_data'
require_relative 'attribute_data'
require_relative 'method_data'
require_relative 'constructor_data'
require_relative 'aggregation_data'

module Languages

  # Handling class information
  class ClassData < Languages::BasicData
    attr_reader :inheritances
    attr_accessor :aggregations
    attr_reader :attributes
    attr_reader :methods
    attr_reader :constructors

    def initialize
      @inheritances = []
      @attributes = []
      @methods = []
      @constructors = []
      @aggregations = []
      @visibility = 'public'
      @comments = ''
    end

    # Add attribute to class data, notice the possibility of call this
    # method more than one time.
    # @param pAttribute Attribute to be added inside class. This attribute
    #         is a list of AttributeData.
    def add_attribute(pAttribute)
      pAttribute.each do |attributeElement|
        next unless attributeElement.is_a?(Languages::AttributeData)
        @attributes.push(attributeElement)
      end
    end

    # Add method inside ClassData. Remember the possibility of have zero or
    # any method inside a class.
    # @param pMethod It is an object of FunctionData with the method
    #         informations.
    def add_method(pMethod)
      return nil unless pMethod.is_a?(Languages::MethodData)

      @methods.push(pMethod)
    end

    # Add constructor inside class.
    # @param pConstructor Object of FunctionData to be added at class.
    def add_constructor(pConstructor)
      return nil unless pConstructor.is_a?(Languages::ConstructorData)

      @constructors.push(pConstructor)
    end

    # Add aggregation inside class.
    # @param pAggregation Object of AggregationData to be added at class.
    def add_aggregation(pAggregation)
      return nil unless pAggregation.is_a?(Languages::AggregationData)

      @aggregations.push(pAggregation)
    end

    # Add inheritance belongs to class. Only accept string, and unique name.
    # @pInheritance Expected string to add inside inheritances array.
    def add_inheritance(pInheritance)
      if !pInheritance.is_a?(String) || @inheritances.include?(pInheritance)
        return nil
      end

      @inheritances.push(pInheritance)
    end
  end # Class
end # Module
