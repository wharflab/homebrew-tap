# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://tally.wharflab.com/"
  license "GPL-3.0-only"
  version "0.36.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.36.0/tally_0.36.0_MacOS_arm64.tar.gz"
      sha256 "9f34728dc32cc2703294deb7f097d7997810145e74e4932f4a0c08e8d6629d9e"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.36.0/tally_0.36.0_MacOS_x86_64.tar.gz"
      sha256 "c4f7331da2a81b85cc16543ed5aab58b3ce0f40815550bd9364d9bdfd42b15a5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.36.0/tally_0.36.0_Linux_arm64.tar.gz"
      sha256 "8ac4e1c394a4c05532d0f0f66963ce3352cd83af0863b2702223e4d1760eb45f"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.36.0/tally_0.36.0_Linux_x86_64.tar.gz"
      sha256 "ca631616264e302e7f32d44d83661a096921999fe042b123ad958addb3b31a0c"
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
