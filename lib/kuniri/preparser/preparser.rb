class PreParser
  def pre_parse(source, out_path)
    pre_parsed_lines = []
    source.each do |line|
      pre_parsed_line = pre_parse_line(line)
      pre_parsed_lines.push(pre_parsed_line) unless (pre_parsed_line.empty?)
    end
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
    lines = split_multiple_command_line(lines)
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

  def remove_newline(line)
    no_newline = line
    no_newline.slice("\n")
    return no_newline
  end
end
