# typed: false
# frozen_string_literal: true

class MeaAgent < Formula
  desc "MEA Local Agent — numérisation et mise en attente de fichiers pour MEA"
  homepage "https://mearchiver.com"
  version "1.0.13"
  license "Proprietary"

  on_macos do
    on_arm do
      url "https://mearchiver-downloads.s3.eu-west-3.amazonaws.com/latest/MEA-LocalAgent-osx-arm64.tar.gz"
      sha256 "87f7a7424425e6ff1280ca8b4f5ac28a75a0eb2b5ee58bdad5270712c608d8be"
    end
    on_intel do
      url "https://mearchiver-downloads.s3.eu-west-3.amazonaws.com/latest/MEA-LocalAgent-osx-x64.tar.gz"
      sha256 "fcdef29a3f5c47f5f3dbf363b0468d141f54143e5582be50733ddf81f6796ded"
    end
  end

  depends_on :macos

  def install
    bin.install "Mea.LocalAgent" => "mea-agent"
    (share/"mea-agent").install "install.sh", "uninstall.sh"
    # Confiance HTTPS du serveur on-prem (hosts + cert) — brew ne peut pas l'exécuter
    # à l'install (pas de sudo), on l'expose donc en commande à lancer une fois.
    bin.install "configure-server-trust.sh" => "mea-agent-trust"
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

      Serveur MEA on-prem (HTTPS) — faire confiance au certificat du serveur (sudo) :
        • avec IP (le nom est aussi ajouté à /etc/hosts) :  mea-agent-trust <ip-serveur>
        • en mode DNS (mearchiver.local résout déjà)     :  mea-agent-trust
      Dans les deux cas la commande importe le certificat du serveur ; sans IP elle
      saute seulement l'étape /etc/hosts (la confiance du cert reste nécessaire).
    EOS
  end
end
