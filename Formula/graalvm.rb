class Graalvm < Formula
  version "1.0.0-rc6"
  url "https://github.com/oracle/graal/releases/download/vm-1.0.0-rc6/graalvm-ce-1.0.0-rc6-macos-amd64.tar.gz"

  def install
    home = prefix/"Contents/Home"
    system "cp -R * #{prefix}/"

    gvm = bin/"gvm"
    gvm.write <<~EOS

#!/bin/sh

export JAVA_HOME=#{home}

if [ "$1" == "ls" ]; then
  ls #{home}/$2
elif [ "$1" == "env" ]; then
  echo #{home}
else
  #{home}/bin/$1 "${@:2}"
fi
    EOS

    chmod 0755, gvm
  end
end