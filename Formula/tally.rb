# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.21.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.21.3/tally_0.21.3_MacOS_arm64.tar.gz"
      sha256 "80ff7828b403c7e765a7c602279dc722509461ca017cadcf9a06c8ebe86eda4a"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.21.3/tally_0.21.3_MacOS_x86_64.tar.gz"
      sha256 "5478fcd3d37007c61bebdb0aadec8de350a3ca6a5675657c8c3e2e17d871d0f8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.21.3/tally_0.21.3_Linux_arm64.tar.gz"
      sha256 "62d566efae5e46c53857caa1a075703616fe53c99de6a4dc1d088904ff63c585"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.21.3/tally_0.21.3_Linux_x86_64.tar.gz"
      sha256 "6d523a667647239f879679ed7a4b0d71247670d66ab53971d5895aec34f568a4"
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
