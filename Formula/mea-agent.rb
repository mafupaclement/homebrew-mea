# typed: false
# frozen_string_literal: true

class MeaAgent < Formula
  desc "MEA Local Agent — numérisation et mise en attente de fichiers pour MEA"
  homepage "https://mearchiver.com"
  version "1.0.4"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://mearchiver-downloads.s3.eu-west-3.amazonaws.com/latest/MEA-LocalAgent-osx-arm64.tar.gz"
      sha256 "441c4320dfc87ae2ff3a5cbfd9f65da0805b2958a211adf915c740272e947fd9"
    end
    on_intel do
      url "https://mearchiver-downloads.s3.eu-west-3.amazonaws.com/latest/MEA-LocalAgent-osx-x64.tar.gz"
      sha256 "a1eb7b0cbe0f7ddb5de785e599287cf2851cee8619014cf8536a2d34e22c3895"
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
