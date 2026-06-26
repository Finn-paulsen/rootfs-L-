# NRF24-Gateway-01 — Login-Screen Setup

Dieses Dokument beschreibt, welche Dateien geändert wurden und welche Befehle
du auf dem Pi 2 ausführen musst, damit alles korrekt läuft.

---

## Was wurde geändert?

| Datei | Änderung |
|---|---|
| `etc/issue` | GOV-ARCHIVE ASCII-Banner mit ANSI-Farben (wird **vor** dem Login-Prompt angezeigt) |
| `etc/update-motd.d/10-hydra-status` | Vollständige System-Status-MOTD mit Farben, Hardware-Check, Security-Layer und Backend-Status |
| `usr/local/bin/check_backend.sh` | Farbige Ausgabe `LINK ESTABLISHED` (grün) / `CONNECTION FAILED` (rot) |
| `usr/local/bin/bootseq` | **Neues Skript:** Interaktive Boot-Sequenz mit Tipp-Effekt, analog zur Hydra `BootSequence.jsx` |
| `home/finn/.bashrc_hydra_append` | Hinweis-Datei: Optionaler `bootseq`-Aufruf beim SSH-Login |

---

## Einmalige Einrichtung auf dem Pi 2

### 1. Repo pullen (SD-Karte im Pi)

```bash
cd /pfad/zum/rootfs
git pull origin main
```

Oder: SD-Karte aus dem Pi ziehen, in den PC einlegen, Dateien manuell kopieren.

### 2. Berechtigungen setzen

```bash
sudo chmod +x /usr/local/bin/check_backend.sh
sudo chmod +x /usr/local/bin/bootseq
sudo chmod +x /etc/update-motd.d/10-hydra-status
```

### 3. MOTD-Daemon sicherstellen (Raspbian)

Auf Raspbian läuft `update-motd` automatisch bei jedem SSH-Login.
Stelle sicher, dass `/etc/pam.d/sshd` die Zeile enthält:

```
session    optional     pam_motd.so  motd=/run/motd.dynamic
```

Das ist auf Raspbian standardmäßig aktiv — nichts weiter nötig.

### 4. `/etc/issue` mit ANSI-Farben aktivieren

Damit die Farben in `/etc/issue` korrekt angezeigt werden, muss `agetty`
mit dem Flag `-e` (escape sequences) laufen. Das ist auf modernen Raspbian-
Versionen standardmäßig der Fall. Falls nicht:

```bash
sudo nano /etc/systemd/system/getty@tty1.service.d/override.conf
```

Inhalt:
```ini
[Service]
ExecStart=
ExecStart=-/sbin/agetty -e --noclear %I $TERM
```

Dann:
```bash
sudo systemctl daemon-reload
sudo systemctl restart getty@tty1
```

---

## Optionaler Boot-Sequenz-Effekt beim SSH-Login

Das Skript `/usr/local/bin/bootseq` simuliert eine animierte Boot-Sequenz
(analog zur Hydra Web-App). Es wird **nicht** automatisch ausgeführt.

Um es beim SSH-Login von `finn` automatisch zu starten, füge folgendes
ans Ende von `/home/finn/.bashrc` hinzu:

```bash
if [ -n "$PS1" ]; then
    /usr/local/bin/bootseq
fi
```

Oder manuell aufrufen:

```bash
bootseq
```

---

## Keine zusätzlichen Pakete nötig

Alle verwendeten Tools (`ping`, `hostname`, `uptime`, `uname`, `awk`) sind
auf Raspbian standardmäßig vorhanden. Es müssen keine Pakete installiert werden.
