# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.18.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.18.6/tally_0.18.6_MacOS_arm64.tar.gz"
      sha256 "c76e28007e005aafd256d433ac5660ee1e96b9bc8539584b51d357641180237f"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.18.6/tally_0.18.6_MacOS_x86_64.tar.gz"
      sha256 "21eb2f038ca8fd9a6c22d76b046a17ac83eea16a904ac7636c7782d7fe41e14a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.18.6/tally_0.18.6_Linux_arm64.tar.gz"
      sha256 "60bf1a0c76dd0228a12420fed917d99cc1b8e91a765131a67964eaac9d14f2fc"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.18.6/tally_0.18.6_Linux_x86_64.tar.gz"
      sha256 "df35b5df185fe8139f758747012dc4e2e1e000506ce717cb0412cd4061769efc"
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
