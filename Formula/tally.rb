# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.31.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.31.0/tally_0.31.0_MacOS_arm64.tar.gz"
      sha256 "68e4141605c0f8834c29ff130b729142e8713db9d90e8831270296033fe8b42e"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.31.0/tally_0.31.0_MacOS_x86_64.tar.gz"
      sha256 "cd975f8c97fcad6bf5fc1aef1a2bc3f125673f316b6e5c18b4678fa93b81e426"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.31.0/tally_0.31.0_Linux_arm64.tar.gz"
      sha256 "f8906f90f04c7a5c453744aaa6e8ea886700da5ee421e599b42c1fb7c25aa657"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.31.0/tally_0.31.0_Linux_x86_64.tar.gz"
      sha256 "ec9b6d74e7bf759176be7bb6f4b23a63dba685c528230fe2332df7a5848747bc"
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
