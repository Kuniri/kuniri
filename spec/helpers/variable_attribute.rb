require 'spec_helper'

module Helpers

  @singleResult = 'value'
  @multiResult = ['value1', 'value2', 'value3', 'value4']

  def multiple_declarations_verify(input, attribute = true)
    listResult = []

    capturedList = attribute_or_global_variable(attribute, input)

    capturedList.each do |element|
      listResult.push(element.name)
    end
    expect(listResult).to match_array(@multiResult)
  end

  def verify_variable_and_value(input, expectedAttributes, expectedValues,
                                attribute = true)
    listOfValues = []
    listOfAttributes = []

    capturedList = attribute_or_global_variable(attribute, input)

    capturedList.each do |element|
      listOfAttributes.push(element.name)
      listOfValues.push(element.value)
    end
    expect(listOfValues).to match_array(expectedValues)
    expect(listOfAttributes).to match_array(expectedAttributes)
  end

  def attribute_or_global_variable(attribute, input)
    if (attribute)
      variable = Languages::Ruby::AttributeRuby.new
      capturedList = variable.get_attribute(input)
    else
      variable = Languages::Ruby::VariableGlobalRuby.new
      capturedList = variable.get_variable(input)
    end
    return capturedList
  end

end

