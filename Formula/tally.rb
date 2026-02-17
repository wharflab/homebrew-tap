# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "Apache-2.0"
  version "0.9.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.9.6/tally_0.9.6_MacOS_arm64.tar.gz"
      sha256 "0063271c61b8cf6bb42b63dc039251294dd09ab8e653af78a91d7316dff836d5"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.9.6/tally_0.9.6_MacOS_x86_64.tar.gz"
      sha256 "b75573a6eae02ccbc209fc767bd70bf92742464107b1a2b7e8f32f38745a2e89"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.9.6/tally_0.9.6_Linux_arm64.tar.gz"
      sha256 "60ea2bb93c1a86ae735b60c59ef2ebfe427bfd467cef4e2312b8ca0222933ebd"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.9.6/tally_0.9.6_Linux_x86_64.tar.gz"
      sha256 "32d4a163bc568cc04fa2c980b3833f3d3ce1d43414723ad1c7fba80d33092992"
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
