# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.18.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.18.4/tally_0.18.4_MacOS_arm64.tar.gz"
      sha256 "3340c65bff720a0652d0a546a601d375dd25199d9de87766ffc6f20b72b088fa"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.18.4/tally_0.18.4_MacOS_x86_64.tar.gz"
      sha256 "62a87a4d05d091a53df2c9945d858dc91f4076878b4fc44b68c8f6b6a9a289ea"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.18.4/tally_0.18.4_Linux_arm64.tar.gz"
      sha256 "dbfa52686149c3c514b8e5169e1fbabbf8952f409dcf829ff83872becfd96761"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.18.4/tally_0.18.4_Linux_x86_64.tar.gz"
      sha256 "6a0bf4cc5fb93008bc157ce9283ed391e4d16a14df2d4cad2c992d34584582b0"
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
