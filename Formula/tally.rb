# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.29.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.29.0/tally_0.29.0_MacOS_arm64.tar.gz"
      sha256 "206e6e2d1f70fd7e55d237dec8968df109b6fa0b005cdd78475eb4bbf30b0a66"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.29.0/tally_0.29.0_MacOS_x86_64.tar.gz"
      sha256 "0d6ac4ae5793b3bd1e68d358c89b352d6db77177ced9cebab0f8cf55e868ea36"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.29.0/tally_0.29.0_Linux_arm64.tar.gz"
      sha256 "97ccef4489ee8b73fe5bfa623507e91fbc15fd0a99ef04f7b9b44ec08c9a2a3b"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.29.0/tally_0.29.0_Linux_x86_64.tar.gz"
      sha256 "3f249fdd5a5e472ee21278fea045df7c396df9dc02010963fe73db87f934c5c0"
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
