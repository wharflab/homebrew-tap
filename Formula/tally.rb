# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.28.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.28.1/tally_0.28.1_MacOS_arm64.tar.gz"
      sha256 "42b6d303db41163505f7386e0e08c0b4f9046f5bc22ff9cfcbe732b555a3994f"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.28.1/tally_0.28.1_MacOS_x86_64.tar.gz"
      sha256 "2f41f1c662f608c8fbeb36aa4d9cb2e6117e3d788942c4bfb6e8b86f03c35c3a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.28.1/tally_0.28.1_Linux_arm64.tar.gz"
      sha256 "40f8e6ff7f8092cf21b5a136ac8abf005ee523532ec9794be765266faf78c2b7"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.28.1/tally_0.28.1_Linux_x86_64.tar.gz"
      sha256 "6b2b6fa14f96e6fad34be92064680cd311ddc0a6e47b24e67adebad96ab5f4ba"
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
