# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://github.com/wharflab/tally"
  license "GPL-3.0-only"
  version "0.22.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.22.0/tally_0.22.0_MacOS_arm64.tar.gz"
      sha256 "ad0073238a04e7decbac4986809b616afe36a763d0be7aca1e3f279d9fcca089"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.22.0/tally_0.22.0_MacOS_x86_64.tar.gz"
      sha256 "98ea9e0550d17bca94a11cd24c2a99ffdff9a66e8d579844191386e94a5602cc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.22.0/tally_0.22.0_Linux_arm64.tar.gz"
      sha256 "727b6b6a04d3ffd76a37490c0945602ef9c95fa652f850baf429a5b607050c5c"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.22.0/tally_0.22.0_Linux_x86_64.tar.gz"
      sha256 "e1a7c61ac18bc63a3b7551941d3d5c46d70b29153d83806719463be899e12cbb"
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
