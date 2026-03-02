# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.19.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.19.0/tally_0.19.0_MacOS_arm64.tar.gz"
      sha256 "7ca044edbd6c83b91939faa6d75d8e5d5cfaa9612dcaeb71d8aad1df73dcf425"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.19.0/tally_0.19.0_MacOS_x86_64.tar.gz"
      sha256 "9ee218463f092f95b328d36957bc49a5e757feaa40483005b84de5f10fecec77"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.19.0/tally_0.19.0_Linux_arm64.tar.gz"
      sha256 "7c8351472da27d67268f2329603ab24a8237984389eeeb3c8425099aecd8e155"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.19.0/tally_0.19.0_Linux_x86_64.tar.gz"
      sha256 "b1e88acf703c6c24efcb116436846d333d34187872d76a63deb41d105f693c7e"
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
