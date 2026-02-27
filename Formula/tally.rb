# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.18.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.18.2/tally_0.18.2_MacOS_arm64.tar.gz"
      sha256 "8c2dd3f9646d9fd044532853a837a7f8a64ddfbab9a1fbbd1e2b20327222236b"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.18.2/tally_0.18.2_MacOS_x86_64.tar.gz"
      sha256 "3cb03c8ed85ece06f2848256aa28ec6ba3fe97fde66a55c2805827756667053b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.18.2/tally_0.18.2_Linux_arm64.tar.gz"
      sha256 "50f19a35e1d4e2a810655f3fc115564c49e3e4b2f97844010d7936dd186db90e"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.18.2/tally_0.18.2_Linux_x86_64.tar.gz"
      sha256 "3d1026b098ee541ec7ed932ce6d73d0a572131b5424545e067f04e1356c68113"
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
