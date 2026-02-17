# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "Apache-2.0"
  version "0.9.10"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.9.10/tally_0.9.10_MacOS_arm64.tar.gz"
      sha256 "122decb5d2e2d3a532c17644ea12bdd6d3b5de8e43c91ac41c344222375565d3"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.9.10/tally_0.9.10_MacOS_x86_64.tar.gz"
      sha256 "12c4cbcff29fa965bc3ed666fef7269da58d5b310bc9acf5f535ea21371f592f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.9.10/tally_0.9.10_Linux_arm64.tar.gz"
      sha256 "b31a4f1b8d44b0287109b1a8454484e56ee8bb79ff5b04cde695a5f9b5eeb29f"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.9.10/tally_0.9.10_Linux_x86_64.tar.gz"
      sha256 "2a67c51546697211861df42a10ac784ea68d32c6ec5252cab1a15403f116d8a9"
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
