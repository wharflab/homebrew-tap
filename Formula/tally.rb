# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.28.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.28.0/tally_0.28.0_MacOS_arm64.tar.gz"
      sha256 "0a420cee7ecc2fb78011a70fe7ee535cc7ed3a3f2197e9829d3bb7e6c34dfb24"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.28.0/tally_0.28.0_MacOS_x86_64.tar.gz"
      sha256 "7e06f8d8a6aa41cedecd9c5eac056420a116338b6ea020703a4d1f25b6b4aade"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.28.0/tally_0.28.0_Linux_arm64.tar.gz"
      sha256 "5550a508ce255de138c0f5d8277e8ad36a54f5867361a622ba9095951f019983"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.28.0/tally_0.28.0_Linux_x86_64.tar.gz"
      sha256 "696ed2ce0a48d9904a74ad2d82299ea5897810d599133de80fb19f17de2cfc54"
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
