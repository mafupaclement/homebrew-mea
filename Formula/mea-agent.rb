# typed: false
# frozen_string_literal: true

class MeaAgent < Formula
  desc "MEA Local Agent — numérisation et mise en attente de fichiers pour MEA"
  homepage "https://mearchiver.com"
  version "1.0.2"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/mafupaclement/My-Electronic-Archiver/releases/download/v1.0.2/MEA-LocalAgent-osx-arm64.tar.gz"
      sha256 "1f31bca9a5fc6e48cbd48d71cdd7458c1c9a631076c45ef6953d4785563cfa91"
    end
    on_intel do
      url "https://github.com/mafupaclement/My-Electronic-Archiver/releases/download/v1.0.2/MEA-LocalAgent-osx-x64.tar.gz"
      sha256 "8c7e20ac38c1c10d6bf99d8484b66144bd1d270a6399fed9880f41e30e672353"
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
