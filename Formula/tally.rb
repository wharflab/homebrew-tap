# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "Apache-2.0"
  version "0.9.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.9.3/tally_0.9.3_MacOS_arm64.tar.gz"
      sha256 "054ebaff047fac506af6c07e28eb516abf1bdc8a1fe23b7c0c29e72be64d5987"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.9.3/tally_0.9.3_MacOS_x86_64.tar.gz"
      sha256 "a43401e910f9d78e4e55b39fd9be1c40cd0e5e2ba00c7594bb629f489836c863"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.9.3/tally_0.9.3_Linux_arm64.tar.gz"
      sha256 "6bf5cad58a6da410755f87bd9af195334655c2a54d09716b1b6e2a6403dc8e11"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.9.3/tally_0.9.3_Linux_x86_64.tar.gz"
      sha256 "be8b0582c79b9ce8fe61b0381615bce60091c4581bc16ca2e0a1b70ae1c5e9ff"
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
