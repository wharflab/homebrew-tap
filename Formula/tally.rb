# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.18.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.18.5/tally_0.18.5_MacOS_arm64.tar.gz"
      sha256 "d8c44e67329798937311249d03b36740989ad4285052bd98ddd72983f313bdc8"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.18.5/tally_0.18.5_MacOS_x86_64.tar.gz"
      sha256 "acc1c0120a67e917170f51bd0319df0a816a4b3c2577bbecac54bbb6d7dd2c69"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.18.5/tally_0.18.5_Linux_arm64.tar.gz"
      sha256 "84464e0f76ab1a996ce7428fd000866608b5f00116dda1e25f938293702cbdd1"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.18.5/tally_0.18.5_Linux_x86_64.tar.gz"
      sha256 "2902de12613fb22c297fe9571d37f9a6d05f68dc29269b420631ea2cb189d6a6"
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
