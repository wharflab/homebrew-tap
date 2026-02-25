# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "Apache-2.0"
  version "0.15.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.15.1/tally_0.15.1_MacOS_arm64.tar.gz"
      sha256 "22bfa971075ba663909b7d20a46b54b42cee10c838a4a470130e54ff60092a7e"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.15.1/tally_0.15.1_MacOS_x86_64.tar.gz"
      sha256 "c012d91e4878aebe53e012f2222ef2e5166f4c7bb022f3f283c3abbe91a44ae2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.15.1/tally_0.15.1_Linux_arm64.tar.gz"
      sha256 "d567c0c1603dc12502821435b8e2672fb20808e9a2a21dc6498c77b1bb5bad03"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.15.1/tally_0.15.1_Linux_x86_64.tar.gz"
      sha256 "3c0510bb42f7a0ecac88a061fc83e5969bc189bb66b6881354aa53f10075c727"
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
