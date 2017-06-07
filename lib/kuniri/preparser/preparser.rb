class PreParser

  def pre_parse(source, out_path)
    pre_parsed_lines = []
    source.each do |line|
      line_content = {}

      pre_parsed_line = pre_parse_line(line)
      comment = get_oneline_comment(pre_parsed_line)

      line_content[:code] = comment.nil? ? pre_parsed_line : nil
      line_content[:comment] = comment.nil? ? nil : comment

      pre_parsed_lines.push(line_content) unless pre_parsed_line.empty?
    end
    pre_parser_lines = get_multiple_lines_comment(pre_parsed_lines) 
    puts(pre_parsed_lines)
    pre_parsed_lines = pre_parsed_lines.map{|line| line[:code] unless line[:code].nil?}.compact
    pre_parsed_lines = pre_parse_multiple_lines(pre_parsed_lines)
    out_file = File.open(out_path, 'w')
    out_file.write(pre_parsed_lines.join("\n"))
    out_file.close
  end

  def pre_parse_line(pre_parsed_line)
    pre_parsed_line = remove_whitespaces(pre_parsed_line)
    pre_parsed_line = remove_newline(pre_parsed_line)
    return pre_parsed_line
  end

  def pre_parse_multiple_lines(lines)
    lines = zip_multiple_lines_command(lines)
    lines = split_multiple_command_lines(lines)
    return lines
  end

  def split_multiple_command_line(_lines)
    raise NotImplementedError
  end

  def zip_multiple_lines_command(_lines)
    raise NotImplementedError
  end

  def remove_whitespaces(line)
    return line.strip
  end

  def remove_comments(_line)
    raise NotImplementedError
  end

  def get_oneline_comment(_line)
    raise NotImplementedError
  end

  def get_multiple_lines_comment(_lines)
    raise NotImplementedError
  end

  def remove_newline(line)
    no_newline = line
    no_newline.slice("\n")
    return no_newline
  end
end
