class Graalvm < Formula
  version "1.0.0-rc6"
  url "https://github.com/oracle/graal/releases/download/vm-1.0.0-rc6/graalvm-ce-1.0.0-rc6-macos-amd64.tar.gz"

  def install
    system "cp -R * #{prefix}/"

    gvm = bin/"gvm"
    gvm.write <<~EOS
#!/bin/sh

export JAVA_HOME=#{prefix}/Contents/Home

if [ "$1" == "ls" ]; then
  ls $JAVA_HOME/$2
elif [ "$1" == "env" ]; then
  echo $JAVA_HOME
else
  #{prefix}/bin "$@"
fi
    EOS

    chmod 0755, gvm
  end
end