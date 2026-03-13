# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.26.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.26.2/tally_0.26.2_MacOS_arm64.tar.gz"
      sha256 "e19d1015f55196d531577f6c0b0b1fd1f455bbc78ca298d10d65bca35c2b32e9"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.26.2/tally_0.26.2_MacOS_x86_64.tar.gz"
      sha256 "9319c4824f27afcad30254d8431be60d586e39fc10eff50e62a7c64d1c7cf0e5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.26.2/tally_0.26.2_Linux_arm64.tar.gz"
      sha256 "4cd57a5f2aa7be0e854be591d11d1bb713ffc7d9ea1f14a0e2fbffa83f36e5ba"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.26.2/tally_0.26.2_Linux_x86_64.tar.gz"
      sha256 "b505a34294c365bddfeff6a5c3a756e006a71bd256615789c8a8001e35c4b09a"
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
