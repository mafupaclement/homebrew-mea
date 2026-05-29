# typed: false
# frozen_string_literal: true

# Homebrew formula pour MEA Local Agent.
#
# Dépôt tap : https://github.com/mafupaclement/homebrew-mea
# Créez le dépôt `mafupaclement/homebrew-mea`, placez ce fichier dans
# `Formula/mea-agent.rb`, puis mettez à jour les sha256 après chaque release.
#
# Mise à jour automatique des sha256 après une release :
#   brew bump-formula-pr mafupaclement/mea/mea-agent --version=<new-version>

class MeaAgent < Formula
  desc "MEA Local Agent — numérisation et mise en attente de fichiers pour MEA"
  homepage "https://mearchiver.com"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://github.com/mafupaclement/My-Electronic-Archiver/releases/latest/download/MEA-LocalAgent-osx-arm64.tar.gz"
      # Mettre à jour après chaque release :
      # sha256 "<sha256-osx-arm64>"
    end
    on_intel do
      url "https://github.com/mafupaclement/My-Electronic-Archiver/releases/latest/download/MEA-LocalAgent-osx-x64.tar.gz"
      # Mettre à jour après chaque release :
      # sha256 "<sha256-osx-x64>"
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
