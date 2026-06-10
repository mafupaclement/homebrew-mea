# typed: false
# frozen_string_literal: true

class MeaAgent < Formula
  desc "MEA Local Agent — numérisation et mise en attente de fichiers pour MEA"
  homepage "https://mearchiver.com"
  version "1.0.11"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://mearchiver-downloads.s3.eu-west-3.amazonaws.com/latest/MEA-LocalAgent-osx-arm64.tar.gz"
      sha256 "c8b6414bf681649ba21ec1206fcbf95a9166e795d05c329f7afa2b6c1f2ca1f6"
    end
    on_intel do
      url "https://mearchiver-downloads.s3.eu-west-3.amazonaws.com/latest/MEA-LocalAgent-osx-x64.tar.gz"
      sha256 "18996d01d018b6a8c3b918305dd563504ccc5132f480ad0309296ff1a0e6e063"
    end
  end

  depends_on :macos

  def install
    bin.install "Mea.LocalAgent" => "mea-agent"
    (share/"mea-agent").install "install.sh", "uninstall.sh"
  end

  service do
    run [opt_bin/"mea-agent"]
    keep_alive true
    log_path var/"log/mea-agent.log"
    error_log_path var/"log/mea-agent-error.log"
    working_dir var
  end

  def caveats
    <<~EOS
      MEA Local Agent est installé comme service Homebrew.

      Prérequis scanner (SANE) :
        brew install sane-backends

      Configurer StagingRoot avant le démarrage :
        export MEA_STAGING_ROOT="$HOME/Documents/MEA/Staging"

      Démarrer le service :
        brew services start mea-agent

      Vérifier :
        curl -s http://127.0.0.1:8100/health
    EOS
  end
end
