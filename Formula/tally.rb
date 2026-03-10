# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.23.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.23.2/tally_0.23.2_MacOS_arm64.tar.gz"
      sha256 "6149908292d753fffaa74f1a778c629a0fc11f6a9729257edacd956a188685df"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.23.2/tally_0.23.2_MacOS_x86_64.tar.gz"
      sha256 "6432708cdaa69ffb87acf04766d19097c1cf9623f5bda25943e83aa191316443"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.23.2/tally_0.23.2_Linux_arm64.tar.gz"
      sha256 "a5855e8f1a7f0c095d592fdc115046c167dbeb8e0c8b5151f1f41aa7c9c18db2"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.23.2/tally_0.23.2_Linux_x86_64.tar.gz"
      sha256 "a489bb13fbf1a41877a467fc23e9d9e4a60c61db12acf94ace62c2733f696424"
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
