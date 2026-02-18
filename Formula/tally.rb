# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "Apache-2.0"
  version "0.10.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.10.0/tally_0.10.0_MacOS_arm64.tar.gz"
      sha256 "6ced1b711e62bf273fc49e250131cf41775fa22a73b3a47a94d0801088028742"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.10.0/tally_0.10.0_MacOS_x86_64.tar.gz"
      sha256 "f0c483c3d5153c97e6a1eaa07ab8d86d498f98bc4989be6fc574da55102edbf4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.10.0/tally_0.10.0_Linux_arm64.tar.gz"
      sha256 "615e5769968ece95cd72e36a7389b2b2811459002b8fbe7fbf9ace349665b8e7"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.10.0/tally_0.10.0_Linux_x86_64.tar.gz"
      sha256 "0263e4b9101a58a36283886afb7788abdc6d75a5e9ba1799300ba2082574f0d2"
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
