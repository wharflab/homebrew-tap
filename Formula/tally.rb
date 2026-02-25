# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.16.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.16.0/tally_0.16.0_MacOS_arm64.tar.gz"
      sha256 "81b5fa19aa2353c5eddba26fb25a3c581f8d43180a7f8be2924b3072121303fc"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.16.0/tally_0.16.0_MacOS_x86_64.tar.gz"
      sha256 "8772ac5f5bfb210fcc60a8c5a908677b1fe47c4bfcbbc74129f03bae6ff528b4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.16.0/tally_0.16.0_Linux_arm64.tar.gz"
      sha256 "7d09632a33354a2f0e9d3f71b8d1bf4f00701c20e59710136114946e5f063fef"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.16.0/tally_0.16.0_Linux_x86_64.tar.gz"
      sha256 "668b86cd8d368ef39b2fe8555ddbe3b4a7f72f79e1edc873f0e95e16f200ab36"
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
