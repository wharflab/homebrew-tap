# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.27.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.27.0/tally_0.27.0_MacOS_arm64.tar.gz"
      sha256 "4527ea06c548035e0da1b555a81d4e3140251bc534ded8190c7c52f00f2f5701"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.27.0/tally_0.27.0_MacOS_x86_64.tar.gz"
      sha256 "61d1525e2762fa77c3dec2cbfc6ff212d639b52d79918748df1c5a6feca76a66"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.27.0/tally_0.27.0_Linux_arm64.tar.gz"
      sha256 "36cd44ef492db7f6cb1fbb8af4a3bdb96f29bc69b7b90afdc84c060a8491d857"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.27.0/tally_0.27.0_Linux_x86_64.tar.gz"
      sha256 "2ce33328b56a648dfe6fe05f33b3cab53259a12e8d4806142fe5f8a8fb1bef33"
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
