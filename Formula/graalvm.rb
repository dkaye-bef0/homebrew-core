class Graalvm < Formula
  version "1.0.0-rc6"
  url "https://github.com/oracle/graal/releases/download/vm-1.0.0-rc6/graalvm-ce-1.0.0-rc6-macos-amd64.tar.gz"

  def install
    gvm = bin/"gvm"

    gvm.write <<~EOS
#!/bin/sh

if [ "$1" == "ls" ]; then
  ls #{prefix}/bin
else
  #{prefix}/bin "$@"
fi
    EOS

    chmod 0755, gvm
  end
end