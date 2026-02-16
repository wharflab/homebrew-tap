# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "Apache-2.0"
  version "0.9.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.9.1/tally_0.9.1_MacOS_arm64.tar.gz"
      sha256 "7e12b50143c03656ef425beb566d860366b776af3b072fb4dd647630e9847674"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.9.1/tally_0.9.1_MacOS_x86_64.tar.gz"
      sha256 "dc70bf91b1d9f2c2ddf00eeba689fddd345c070b8d2fcf61b96ed00ceb128644"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.9.1/tally_0.9.1_Linux_arm64.tar.gz"
      sha256 "a639dcdd2e9c8984f8f3d2dc0c77096f8221086c7c0aa322e183c68377404483"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.9.1/tally_0.9.1_Linux_x86_64.tar.gz"
      sha256 "d985e5ffe98b96d3f917ff2594106d40999154146e9cfbea479197f011115edc"
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
