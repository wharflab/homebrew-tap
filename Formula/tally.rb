# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.21.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.21.2/tally_0.21.2_MacOS_arm64.tar.gz"
      sha256 "475213fb0f586f2174d6c021f0f65d62b60644e031ef4564629040af8db161d9"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.21.2/tally_0.21.2_MacOS_x86_64.tar.gz"
      sha256 "5a5d45c9fb1161978dbc8ea5b87f6924f70f91d94f2ff9a67b2852f46bfad369"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.21.2/tally_0.21.2_Linux_arm64.tar.gz"
      sha256 "122f0358f94bf08b9f9fb0d8a6285eb335820e588ec3ef36de8d2e01aabc4480"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.21.2/tally_0.21.2_Linux_x86_64.tar.gz"
      sha256 "01b3593543251109ae29646b00c0325092dbfdf00f9d5465c6d216172fec789e"
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
