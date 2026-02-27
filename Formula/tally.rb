# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.18.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.18.7/tally_0.18.7_MacOS_arm64.tar.gz"
      sha256 "a1508fb1440fc52bb194eb519951f45ba92816f0e7e7e4f8cc01848631b621a9"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.18.7/tally_0.18.7_MacOS_x86_64.tar.gz"
      sha256 "923ee3c70d812d0e8dd28e853908986fbcc1a694c1bc91ec32a2c17b121e52af"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.18.7/tally_0.18.7_Linux_arm64.tar.gz"
      sha256 "69c98e2d0bfef025ad63fdbbd73ee61678d9e93951004df85e8dbfcbb94277c6"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.18.7/tally_0.18.7_Linux_x86_64.tar.gz"
      sha256 "469664e6758ff02fbbc7f184c6d032ec63ce45c098c9d331fb12e944df7a0380"
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
