# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "Apache-2.0"
  version "0.12.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.12.0/tally_0.12.0_MacOS_arm64.tar.gz"
      sha256 "83068dc441aa685d14894d2e4fabd95ddd8d53ed55aa08159254297d0f519f00"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.12.0/tally_0.12.0_MacOS_x86_64.tar.gz"
      sha256 "2691ee38ec3fe5271235cd8fd4132bcfec619ac0dd3ed8a20f3d09b2aabbbb99"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.12.0/tally_0.12.0_Linux_arm64.tar.gz"
      sha256 "45b32cddf3510ffdb5fe4f7b4eb66ecb7b50e6bdd990bcc3e88e2cfe1e8074df"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.12.0/tally_0.12.0_Linux_x86_64.tar.gz"
      sha256 "637e2de25399b726d137123e76e1fbb9b1e967b612bbd34f112f744a15988ac5"
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
