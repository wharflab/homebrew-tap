# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.18.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.18.3/tally_0.18.3_MacOS_arm64.tar.gz"
      sha256 "e4f0cb30167aaa7f4c7ba2f9f92c63a705c7a28aa524f162ce80aab8c6c55088"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.18.3/tally_0.18.3_MacOS_x86_64.tar.gz"
      sha256 "0d64cb8ff002cb4cde3a8eba81b282757248ffffff60599278dfbf1e52552587"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.18.3/tally_0.18.3_Linux_arm64.tar.gz"
      sha256 "0e675292c5928364e44bf8a5fff966b83e7123f8bd7133d32fadf899e714ed55"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.18.3/tally_0.18.3_Linux_x86_64.tar.gz"
      sha256 "59d8536149a4ad6948018412a38943a683c2e891ad3984ece4311116746b33b0"
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
