class Shake < Formula
  version "0.0.1"
  url "https://github.com/dkaye-bef0/homebrew-core/raw/master/Archive/empty.tar.bz2"
  depends_on "haskell-stack"

  def install
    # system "stack", "install", "shake"
    build = bin/"build"

    build.write <<~EOS
      #!/bin/sh
      mkdir -p .shake
      stack exec -- ghc --make Build.hs -rtsopts -threaded -with-rtsopts=-I0 -outputdir=.shake -o .shake/shake && .shake/shake "$@"
    EOS

    chmod 0755, build
  end
end