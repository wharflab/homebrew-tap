# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.17.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.17.0/tally_0.17.0_MacOS_arm64.tar.gz"
      sha256 "d70f4181ddb5cc3d70c23b0cd24128e4b468c39210b9301d5f84bb170fc68301"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.17.0/tally_0.17.0_MacOS_x86_64.tar.gz"
      sha256 "caa54e84c0b26b5e7b9c4bf3582f39ff83f1501a6fcf98773de982512e1c3573"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.17.0/tally_0.17.0_Linux_arm64.tar.gz"
      sha256 "58551c079ae570c240b443194a448bfd03e5a7f1353bfb1dda4709bdc57454df"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.17.0/tally_0.17.0_Linux_x86_64.tar.gz"
      sha256 "a01997a161e98044387f35e8b1f16ed0e20b467aefeccbb8e0b5c911371a600a"
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
