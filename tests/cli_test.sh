. $(dirname $0)/helper/test_helper.sh

test_verify_version() {
  version=`cat ./VERSION`
  output=`bin/kuniri --version`
  assertEquals $version $output
}

test_verify_help() {
  output=`bin/kuniri --help`
  assertEquals 0 "$?"
  output=`bin/kuniri -h`
  assertEquals 0 "$?"
}

test_verbose_level() {
  file="spec/samples/rubySyntaxParts/class/simpleClass.rb"
  output=`bin/kuniri $file -v`
  contains "$output" "INFO"
  assertEquals 0 "$?"
}

create_test_file() {
  cat <<EOF >expected_result.xml
<?xml version="1.0" encoding="UTF-8"?>
<kuniri>
  <classData name="Simple1" visibility="public">
  </classData>
  <classData name="Simple2" visibility="public">
  </classData>
  <classData name="Simple3" visibility="public">
  </classData>
  <classData name="Simple4" visibility="public">
  </classData>
  <classData name="Simple5" visibility="public">
  </classData>
</kuniri>
EOF
  file="spec/samples/rubySyntaxParts/class/simpleClass.rb"
}

test_output_analysis() {
  create_test_file
  output=`bin/kuniri $file`
  diff expected_result.xml outputKuniri.xml
  assertEquals 0 "$?"
}

test_output_analysis_specifying_output() {
  create_test_file
  output=`bin/kuniri $file -o real_result.xml`
  diff expected_result.xml real_result.xml
  assertEquals 0 "$?"
}

test_missing_arguments() {
  file="spec/samples/rubySyntaxParts/class/simpleClass.rb"
  output=`bin/kuniri $file -o`
  contains "$output" "missing argument"
  assertEquals 0 "$?"

  output=`bin/kuniri $file -l`
  contains "$output" "missing argument"
  assertEquals 0 "$?"
}

test_invalid_arguments() {
  file="spec/samples/rubySyntaxParts/class/simpleClass.rb"
  output=`bin/kuniri $file -fake`
  contains "$output" "invalid option"
  assertEquals 0 "$?"
}

load_shunit2
