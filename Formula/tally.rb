# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.27.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.27.2/tally_0.27.2_MacOS_arm64.tar.gz"
      sha256 "ef981e1c44ce9d957eeb0701eb67be7364059385f4f4675ceaa99db16f7fe439"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.27.2/tally_0.27.2_MacOS_x86_64.tar.gz"
      sha256 "9f5299b30247283250f21554fa16ca0442563517d38b49c1be3151f745cdc7f3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.27.2/tally_0.27.2_Linux_arm64.tar.gz"
      sha256 "3caaf5d8f9472a95244ca62e55af879cafc69a87307ccc4f06601fb379d50044"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.27.2/tally_0.27.2_Linux_x86_64.tar.gz"
      sha256 "2b95c107a2f7fb432a52b483c4990aab8273910ea6170cef14486daa3e0641f4"
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
