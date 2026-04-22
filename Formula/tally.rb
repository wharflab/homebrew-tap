# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.35.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.35.2/tally_0.35.2_MacOS_arm64.tar.gz"
      sha256 "599c70bac9e270871d81a24ab077e8f6dd350534bda48883e005d6a9483cbc58"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.35.2/tally_0.35.2_MacOS_x86_64.tar.gz"
      sha256 "3e2cff8f990fe0ae19392c359597401ec4c8f08e7f196ad0d0f37c46d75127a5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.35.2/tally_0.35.2_Linux_arm64.tar.gz"
      sha256 "ae5240ea2a096cfe126d46119b5d3b14ac125371afa0fed216740dccb0c961b4"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.35.2/tally_0.35.2_Linux_x86_64.tar.gz"
      sha256 "f44650d5f20b1f4a354cb0e1fc36f8c0ee51cf8382caf1668f259dbd1c60c433"
    end
  end

  def install
    bin.install "tally"
  end

  test do
    # Create a simple Dockerfile to test
    (testpath/"Dockerfile").write <<~DOCKERFILE
      FROM alpine:latest
      RUN echo "hello"
    DOCKERFILE

    # Run tally and check it executes successfully
    output = shell_output("#{bin}/tally check #{testpath}/Dockerfile --format json")
    assert_match "files_scanned", output

    # Verify version output
    assert_match version.to_s, shell_output("#{bin}/tally version")
  end
end
