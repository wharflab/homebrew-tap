# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.20.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.20.0/tally_0.20.0_MacOS_arm64.tar.gz"
      sha256 "3497b7793e74fe2d500503bddaaf257fdc6a70cd55b5344a6d33cde3c9bd436a"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.20.0/tally_0.20.0_MacOS_x86_64.tar.gz"
      sha256 "f66782b1e5969853d81ffd2819a36c772bb13615142af7079b1419b7d311844e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.20.0/tally_0.20.0_Linux_arm64.tar.gz"
      sha256 "10be3581059328d158a182198237d5a2a1f50c66f2285f056f1e9d26f3f9bcc8"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.20.0/tally_0.20.0_Linux_x86_64.tar.gz"
      sha256 "ea49fb89275e963c206d8c6d6b3b34d52516c38cf8e0a230b0c7350c6bdb1655"
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
