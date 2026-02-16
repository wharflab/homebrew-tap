# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "Apache-2.0"
  version "0.9.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.9.4/tally_0.9.4_MacOS_arm64.tar.gz"
      sha256 "92cac36a6b3dcf16327288a04cfd48a23b6c46b9e09482e1ca4b97888a4737e1"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.9.4/tally_0.9.4_MacOS_x86_64.tar.gz"
      sha256 "b6cf14a25d43272beca7fdb8e4db842a88d04ae12148e8686919d693361bda0d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.9.4/tally_0.9.4_Linux_arm64.tar.gz"
      sha256 "c81e5b8765f1b154e66d264429c847ecef5d8bacf25547515865667258e121ac"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.9.4/tally_0.9.4_Linux_x86_64.tar.gz"
      sha256 "6107ef8d4e8fb47d98723ad06941cb06d0da7d251b670f705a2433c2569e4057"
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
