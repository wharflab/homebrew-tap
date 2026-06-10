# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://tally.wharflab.com/"
  license "AGPL-3.0-only"
  version "0.44.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.44.1/tally_0.44.1_MacOS_arm64.tar.gz"
      sha256 "e9f6e388e69cd2d7eb0b2aeec94fefe29abf2f15ad6544d7b4dbf067a90e1ea3"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.44.1/tally_0.44.1_MacOS_x86_64.tar.gz"
      sha256 "7f371396195c56897912e7ba1a83d5423aec07ade64015cc27bc0ad5638716e6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.44.1/tally_0.44.1_Linux_arm64.tar.gz"
      sha256 "7421c2909fc9e5d343d7968e4d79a89ea52a447598d9caf1c5f0740ed71454be"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.44.1/tally_0.44.1_Linux_x86_64.tar.gz"
      sha256 "741074134ef7db1c7bcae748c257c283158ed1fcab23841c3dc5b477a0beb6b5"
    end
  end

  def install
    bin.install "tally"
    (lib/"docker/cli-plugins").install_symlink bin/"tally" => "docker-lint"
  end

  def caveats
    <<~EOS
      To register tally as the per-user Docker CLI plugin:

        tally register-docker-plugin

      A Homebrew-managed docker-lint symlink is also installed in:

        #{HOMEBREW_PREFIX}/lib/docker/cli-plugins

      If you prefer that path, add it to Docker's "cliPluginsExtraDirs" in
      ~/.docker/config.json.
    EOS
  end

  test do
    require "json"

    # Create a simple Dockerfile to test
    (testpath/"Dockerfile").write <<~DOCKERFILE
      FROM alpine:latest
      RUN echo "hello"
    DOCKERFILE

    # Run tally and check it executes successfully
    output = shell_output("#{bin}/tally lint #{testpath}/Dockerfile --format json --ignore '*'")
    assert_match "files_scanned", output

    # Verify Docker CLI plugin metadata without requiring Docker itself
    metadata = JSON.parse(shell_output("#{lib}/docker/cli-plugins/docker-lint docker-cli-plugin-metadata"))
    assert_equal "0.1.0", metadata["SchemaVersion"]
    assert_equal "Wharflab", metadata["Vendor"]

    fakebin = testpath/"fakebin"
    fakebin.mkpath
    (fakebin/"docker").write <<~SH
      #!/bin/sh
      if [ "$1" = "info" ] && [ "$2" = "--format" ] && [ "$3" = "json" ]; then
        plugin="$DOCKER_CONFIG/cli-plugins/docker-lint"
        if [ -e "$plugin" ]; then
          printf '{"ClientInfo":{"Version":"29.4.1","Plugins":[{"Name":"lint","Vendor":"Wharflab","Version":"#{version}","ShortDescription":"Lint Dockerfiles and Containerfiles","Path":"%s"}]}}' "$plugin"
        else
          printf '{"ClientInfo":{"Version":"29.4.1","Plugins":[]}}'
        fi
        exit 0
      fi
      exit 1
    SH
    chmod 0755, fakebin/"docker"
    ENV["DOCKER_CONFIG"] = testpath/".docker"
    ENV.prepend_path "PATH", fakebin
    system "#{bin}/tally", "register-docker-plugin"
    plugin = testpath/".docker/cli-plugins/docker-lint"
    assert_predicate plugin, :exist?
    metadata = JSON.parse(shell_output("#{plugin} docker-cli-plugin-metadata"))
    assert_equal "0.1.0", metadata["SchemaVersion"]
    assert_equal "Wharflab", metadata["Vendor"]

    # Verify version output
    assert_match version.to_s, shell_output("#{bin}/tally version")
  end
end
