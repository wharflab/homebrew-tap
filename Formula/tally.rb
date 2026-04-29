# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://tally.wharflab.com/"
  license "GPL-3.0-only"
  version "0.38.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.38.0/tally_0.38.0_MacOS_arm64.tar.gz"
      sha256 "55fa6144597ff6148e13dcb331668a0d8b12023993f41968e1f0961534ce49d1"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.38.0/tally_0.38.0_MacOS_x86_64.tar.gz"
      sha256 "ec891f6965bb9e74e9514a244635b3acb42e02a69579089c0393aa24b0e5d1cb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.38.0/tally_0.38.0_Linux_arm64.tar.gz"
      sha256 "e289a10c30090dfa2359b7bdfecb1f36820a888677a24544ea691d607d47edab"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.38.0/tally_0.38.0_Linux_x86_64.tar.gz"
      sha256 "ed4235277e59f0ce9ffaa1c936da0e5d078b93bc9cae4873fdba90e9c2e2639a"
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
