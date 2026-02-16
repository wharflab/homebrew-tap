# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "Apache-2.0"
  version "0.9.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.9.5/tally_0.9.5_MacOS_arm64.tar.gz"
      sha256 "63c915721e11ee5315c53ebb250d2faf27981f272e632543cf6bab7ef95d7b7e"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.9.5/tally_0.9.5_MacOS_x86_64.tar.gz"
      sha256 "4159b349da04571287a5606f908786323aac66653ddf30dd76b4a6d6b4075ccf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.9.5/tally_0.9.5_Linux_arm64.tar.gz"
      sha256 "6e4cb5af2a1e07ae664ac213bc8b4fc207bdae274b86314143e6251c49a921c7"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.9.5/tally_0.9.5_Linux_x86_64.tar.gz"
      sha256 "8022ad6970f9dffa75634038d6cda4ec986f47135a53856f9a69f336b839cab7"
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
