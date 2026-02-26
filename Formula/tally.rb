# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.18.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.18.1/tally_0.18.1_MacOS_arm64.tar.gz"
      sha256 "ccf116af3b4e6dd412579701faf6e4cbbb38afd3df95cebb190f276a405c5511"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.18.1/tally_0.18.1_MacOS_x86_64.tar.gz"
      sha256 "3101abbdc89d720dc19d41ae1e2210c52361a431fee9c9f69fecac28da1db4ba"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.18.1/tally_0.18.1_Linux_arm64.tar.gz"
      sha256 "0e224cb8c1b26771a1aa2caedb3ed610d38916fa9ba7ff388a193ade9ea47a41"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.18.1/tally_0.18.1_Linux_x86_64.tar.gz"
      sha256 "31d6e9999c1b5107216a57eabef8a868e9e101387bbd62302bc688f207859944"
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
