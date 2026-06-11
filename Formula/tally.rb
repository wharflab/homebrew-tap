# typed: false
# frozen_string_literal: true

# Homebrew formula for tally - auto-generated, do not edit manually
class Tally < Formula
  desc "Fast, configurable linter for Dockerfiles and Containerfiles"
  homepage "https://tally.wharflab.com/"
  license "AGPL-3.0-only"
  version "0.44.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.44.2/tally_0.44.2_MacOS_arm64.tar.gz"
      sha256 "6ec64d7a306dcf580f02e023a046032e16129ac7877ba5ff671c4322306766f3"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.44.2/tally_0.44.2_MacOS_x86_64.tar.gz"
      sha256 "bc02f125f2e10e0a935691ba851604df1a6f536c4608c542def1c4a6919b3e79"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/wharflab/tally/releases/download/v0.44.2/tally_0.44.2_Linux_arm64.tar.gz"
      sha256 "40428801305a16ba52e1cdeaf3a05b83ae01ea71d9db68a5b93ef44161a7acfc"
    else
      url "https://github.com/wharflab/tally/releases/download/v0.44.2/tally_0.44.2_Linux_x86_64.tar.gz"
      sha256 "d51744ba5ba5bcb107856092dd786790eb49e1244dc05f58922b0146fea86092"
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
