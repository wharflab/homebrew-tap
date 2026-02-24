# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "Apache-2.0"
  version "0.14.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.14.0/tally_0.14.0_MacOS_arm64.tar.gz"
      sha256 "e75d0789441e93edcae5748e71edf65f68936c20a204c12753f6f72088561863"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.14.0/tally_0.14.0_MacOS_x86_64.tar.gz"
      sha256 "5882f4ad27c591dcf81e17558d6ffb9dcffc953192a34088608ea226aeff6495"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.14.0/tally_0.14.0_Linux_arm64.tar.gz"
      sha256 "27a19759717284769de0894393f405eadf1b61ced6f8734762f158642d7fd988"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.14.0/tally_0.14.0_Linux_x86_64.tar.gz"
      sha256 "aeae7ea6c642746080b4b24138fdcff735d014d14808f571a72888a569732587"
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
