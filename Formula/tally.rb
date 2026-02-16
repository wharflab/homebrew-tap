# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "Apache-2.0"
  version "0.9.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.9.2/tally_0.9.2_MacOS_arm64.tar.gz"
      sha256 "7467cb728d09abae9850acfe91b8b6be6685f5d9bb8ce88d4cee81b343a90ab4"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.9.2/tally_0.9.2_MacOS_x86_64.tar.gz"
      sha256 "09ab1543e97c57ad9f955e5ad7b8dc34997c193b1e07ea8ae73a50f5000738a8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.9.2/tally_0.9.2_Linux_arm64.tar.gz"
      sha256 "71a2a34db6890f148b19439ea26c321a8aa89bf2b7f4bd0c1833a720a86c20cd"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.9.2/tally_0.9.2_Linux_x86_64.tar.gz"
      sha256 "c8b097c0652ecef3d4c91c7881fe8f425a926b449ee92a3c1343215b750c523b"
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
