export PATH="$(dirname $0)/bin:$PATH"
export ROOTDIR="$(dirname $0)/.."

load_shunit2() {
  if [ -e /usr/share/shunit2/shunit2 ]; then
    . /usr/share/shunit2/shunit2
  else
    . shunit2
  fi
}

contains() {
  string="$1"
  substring="$2"
  if test "${string#*$substring}" != "$string"
  then
      return 0
  else
      return 1
  fi
}

