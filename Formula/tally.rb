# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "Apache-2.0"
  version "0.15.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.15.0/tally_0.15.0_MacOS_arm64.tar.gz"
      sha256 "43e929652a963331291816aad52c87de326f8ce6a659b5ac7d608e5845a1210d"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.15.0/tally_0.15.0_MacOS_x86_64.tar.gz"
      sha256 "0218a90d4fd216ebad2f5b9d44fdeee86cf0e6d1f487ed108b84a58fa131bad7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.15.0/tally_0.15.0_Linux_arm64.tar.gz"
      sha256 "b1856de9690e5a3b3518d4d1ecf21ba8ac80b2563693be5c9caaf4c1fd9d2298"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.15.0/tally_0.15.0_Linux_x86_64.tar.gz"
      sha256 "90f067090024e17ad64c4650ba6556a66fe2c5220280e47dd4e91359304664fe"
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
