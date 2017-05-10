#
# Copyright (C) 2015-2017 Rodrigo Siqueira  <siqueira@kuniri.org>
#
# This source code is licensed under the GNU lesser general public license,
# Version 3.  See the file COPYING for more details

module Parser

  class XMLBuilderEngine

    attr_reader :tag
    attr_reader :betweenTag
    attr_reader :ident
    attr_accessor :identIncrement
    attr_reader :optimizationLevel

    def initialize(pBaseSpaceIdent = 2, pLevel = 0)
      set_default(pBaseSpaceIdent)
      @optimizationLevel = pLevel
      set_default(0) if (@optimizationLevel == 1)
    end

    def to_xml
      return @tag
    end

    def reset_engine
      @tag = nil
      set_default
    end

    def set_default(pBaseSpaceIdent = 2)
      @tag = '<?xml version="1.0" encoding="UTF-8"?>'
      @baseSpaceIdentation = pBaseSpaceIdent
      @content = ''
      @ident = ''
      @identIncrement = ' ' * pBaseSpaceIdent
    end

    private

    def method_missing(pTagName, *pTagParameters, &pBlock)
      @tag << "\n" unless @tag.strip == ''
      name = @optimizationLevel != 1 ? pTagName.to_s : optimize_size(pTagName)
      currentTagName = "#{@ident}<#{name}"
      @tag << currentTagName

      handle_arguments(pTagParameters) if (pTagParameters[0].is_a? Hash)

      if (block_given?)
        open_block_tag(&pBlock)
        close_block_tag(name)
      else
        @tag << "/>\n"
      end

      super if pTagName == ''
      @content = ''
    end

    def respond_to_missing?(method_name, include_private = false)
      super
    end

    def optimize_size(pTagName)
      return OPTIMIZE_OUTPUT_MAP[pTagName.to_sym] || pTagName.to_s
    end

    def open_block_tag(&pBlock)
      @tag << ">\n"
      increment_identation
      result = instance_eval(&pBlock)
      update_tag(result) if result != '' && result.is_a?(String)
    end

    def close_block_tag(pName)
      decrement_ident
      @tag << "#{@ident}</#{pName}>\n"
      @tag.squeeze!("\n")
    end

    def update_tag(pNewContent)
      @content = "\n#{@ident}" + pNewContent + "\n"
      @tag << @content
    end

    def handle_arguments(pTagParameters)
      pTagParameters[0].each do |key, value|
        stringValue = handle_special_characters_xml(value.to_s)
        key = optimize_size(key) unless (@optimizationLevel != 1)
        @tag << " #{key}=\"#{stringValue}\""
      end
    end

    def handle_special_characters_xml(pString)
      if (pString.count('"').positive? || pString.count('&').positive? ||
          pString.count('>').positive? || pString.count('<').positive?)
        pString = pString.tr('"', "'").gsub('&', '&amp;').gsub('>', '&gt;')
                         .gsub('<', '&lt;')
      end
      return pString
    end

    def increment_identation
      @ident << @identIncrement
    end

    def decrement_ident
      return if @ident.empty?
      @ident = @ident[0...(@ident.size - @baseSpaceIdentation)]
    end

  end
end
