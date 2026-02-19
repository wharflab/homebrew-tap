# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "Apache-2.0"
  version "0.10.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.10.2/tally_0.10.2_MacOS_arm64.tar.gz"
      sha256 "bb254411d6dd42260a8415561250995307147493707089d453414f6b9ef8dc47"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.10.2/tally_0.10.2_MacOS_x86_64.tar.gz"
      sha256 "78ef5636585f6f655cedd22d8b7501574cddb99057f3b072e12ec5b644fad2f1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.10.2/tally_0.10.2_Linux_arm64.tar.gz"
      sha256 "3aef708d65c66af95a9368bb92c6cf619b901f6d5c3ddc92ea4eca304be2d14b"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.10.2/tally_0.10.2_Linux_x86_64.tar.gz"
      sha256 "ecae207de6a08eed13fd65d9209935538fd8c8aab976c0ad3e581ea2d3d77635"
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
