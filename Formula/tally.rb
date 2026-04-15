# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.33.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.33.0/tally_0.33.0_MacOS_arm64.tar.gz"
      sha256 "cefed4bf9f3e937de76647fd81276a92fb64212a662a37674e55d456c28946b4"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.33.0/tally_0.33.0_MacOS_x86_64.tar.gz"
      sha256 "07f765da4286b64dcf9d7058c3c11250f598a35c960151b2e178ced5f15a1a1e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.33.0/tally_0.33.0_Linux_arm64.tar.gz"
      sha256 "18277bab3878ed3448c04926f9f4c79d513f6f2facf8cc0693e7e0ad6b058ba4"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.33.0/tally_0.33.0_Linux_x86_64.tar.gz"
      sha256 "32a17e555ff01b562b2cddb381aede6c318e8983f3ca462f5de4a6652b774ad5"
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
