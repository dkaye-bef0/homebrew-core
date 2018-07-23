class Dynamodb < Formula
  version "0.0.1"

  url "https://s3-us-west-2.amazonaws.com/dynamodb-local/dynamodb_local_latest.tar.gz"
  homepage "https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.html"

  def install
    system "cp -R * #{prefix}/"
    wrapper = prefix/"dynamodb-local.wrapper.sh"

    wrapper.write <<~EOS
      #!/bin/sh
      java -Djava.library.path="./DynamoDBLocal_lib" -jar "DynamoDBLocal.jar" "$@"
    EOS

    chmod 0755, wrapper
    (var/"log").mkpath
  end

  def plist; <<~EOS
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
        <dict>
          <key>SuccessfulExit</key>
          <false/>
        </dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>#{prefix}/dynamodb-local.wrapper.sh</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>WorkingDirectory</key>
        <string>#{prefix}</string>
        <key>StandardErrorPath</key>
        <string>#{var}/log/dynamodb.log</string>
        <key>StandardOutPath</key>
        <string>#{var}/log/dynamodb.log</string>
      </dict>
    </plist>
  EOS
  end
end