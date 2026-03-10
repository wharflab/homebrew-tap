# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.23.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.23.1/tally_0.23.1_MacOS_arm64.tar.gz"
      sha256 "d1b3963a6c4b31bef636fffe5b6d6bddb5c158cc9c3d6d951e01d1257ebcec85"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.23.1/tally_0.23.1_MacOS_x86_64.tar.gz"
      sha256 "43381ef7a292b4ffd456454bfc8bebe50bb5785e2e4b0fe63eb50f5db62eda6f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.23.1/tally_0.23.1_Linux_arm64.tar.gz"
      sha256 "911de26ab29f1b3193bbd8a6cf23026473da06faf72ae2cb55a0669a966bbde1"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.23.1/tally_0.23.1_Linux_x86_64.tar.gz"
      sha256 "1d71be4226a5af69918eebb9203c49d4c933afb8db804ffa0c0d798f4839b378"
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
