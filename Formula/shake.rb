class Dynamodb < Formula
  version "0.0.1"

  url "https://github.com/dkaye-bef0/homebrew-core/raw/master/Archive/empty.tar"

  def install
    system "stack install shake"
    build = prefix/"build.sh"

    build.write <<~EOS
      #!/bin/sh
      mkdir -p .shake
      ghc --make Build.hs -rtsopts -threaded -with-rtsopts=-I0 -outputdir=.shake -o .shake/shake && .shake/shake "$@"
    EOS

    chmod 0755, build
  end
end