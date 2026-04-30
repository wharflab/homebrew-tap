# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://tally.wharflab.com/"
  license "GPL-3.0-only"
  version "0.39.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.39.0/tally_0.39.0_MacOS_arm64.tar.gz"
      sha256 "27392a2c0207038a32c8e10baeb18532476d3c5a4763937ebd40d81d8d5cd074"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.39.0/tally_0.39.0_MacOS_x86_64.tar.gz"
      sha256 "a1002938ef2eabe22821ecfa155d0a7985b4cc248ec208c74e178cb69e371149"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.39.0/tally_0.39.0_Linux_arm64.tar.gz"
      sha256 "bbaab5d5b51a839cfcd5987b318609a05b931a0d5e1226957e13fe001849b94f"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.39.0/tally_0.39.0_Linux_x86_64.tar.gz"
      sha256 "1b92c73c23aea02382701be8a6c5c61c447379938386462bf04e2c2d619aafe5"
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
