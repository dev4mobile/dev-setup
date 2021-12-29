#!/bin/bash

# set -x
set -e

# https://github.com/thoughtbot/laptop

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n$fmt\\n" "$@"
}

macos_dev_env_init() {
# brew install clashx
# brew install wireshark
 local apps=(
    # docker
    # charles
    test 
  )
  brew install "${apps[@]}"

  local gui_apps=(clashx chrome wireshark)
  brew install --cask "${gui_apps[@]}"
  brew cleanup
}

linux_dev_env_init() {
	if ! command -v sdk > /dev/null; then
		curl -s "https://get.sdkman.io" | bash
		source "$HOME/.sdkman/bin/sdkman-init.sh"
		echo "$(sdk version)"
	fi			
	# install java
	jdk8_version=$(sdk list java | grep -E '8.*zulu' | head -n 1 | awk '{print $NF}')
	sdk install java ${jdk8_version}
}

# install brew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

if test "$(uname)" == 'Darwin'; then
  echo "MacOS detected" 
  macos_dev_env_init
else
  echo "Linux detected"
  linux_dev_env_init
fi


