# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.27.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.27.1/tally_0.27.1_MacOS_arm64.tar.gz"
      sha256 "276f4157fff9771fceb4e0fd1cd40556c1498fe153eb2864f046d58bcd768d8a"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.27.1/tally_0.27.1_MacOS_x86_64.tar.gz"
      sha256 "6b08cca42c2fe6e79c167680c026c7c7c11a068b83a8e005ca50a258b308bbf0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.27.1/tally_0.27.1_Linux_arm64.tar.gz"
      sha256 "c7eb8062bd1022eb8d4f3a2c65354cb1fa600c2517cfa2e61be430eafa85184e"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.27.1/tally_0.27.1_Linux_x86_64.tar.gz"
      sha256 "e0e8ce769abea63b98d9f7acb8ea9e55245e1b56a2576f1ede3655bd8e35299f"
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
