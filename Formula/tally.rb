# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.21.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.21.0/tally_0.21.0_MacOS_arm64.tar.gz"
      sha256 "75447dde4fa823a7b820800cc4b946a9377b7982a2cbc3cc093e4425e8c224b5"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.21.0/tally_0.21.0_MacOS_x86_64.tar.gz"
      sha256 "0371702d56a28ed7aedfe7df629278e4fd7ade631018a6ba4ad37899bd3aa470"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.21.0/tally_0.21.0_Linux_arm64.tar.gz"
      sha256 "8a7f19586989ec51062572bb719d8c61a2d6f69b64961c78b858c209c27cb3fb"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.21.0/tally_0.21.0_Linux_x86_64.tar.gz"
      sha256 "932cf0c5c6a1310e7b7ce80e3644c1996cc84c83ff5d25c5e413cc3c62b5896b"
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
