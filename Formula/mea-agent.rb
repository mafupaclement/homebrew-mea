# typed: false
# frozen_string_literal: true

class MeaAgent < Formula
  desc "MEA Local Agent — numérisation et mise en attente de fichiers pour MEA"
  homepage "https://mearchiver.com"
  version "1.0.7"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://mearchiver-downloads.s3.eu-west-3.amazonaws.com/v1.0.7/MEA-LocalAgent-osx-arm64.tar.gz"
      sha256 "09d263047e2a3673e1407091625bbed86e743647257138af71b03d0b4f857c0d"
    end
    on_intel do
      url "https://mearchiver-downloads.s3.eu-west-3.amazonaws.com/v1.0.7/MEA-LocalAgent-osx-x64.tar.gz"
      sha256 "88971a7147b009e55cbc45eb7d6c9c2d58b5eb5fbe211107d4f3b18018f50917"
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
