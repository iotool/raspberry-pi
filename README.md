# raspberry-pi

## Befehle

```bash
sudo shutdown -h now                        RPi stoppen
sudo reboot                                 RPi neu starten
sudo raspi-config                           RPi konfigurieren
```

## RaspiOS installieren

* Download & Unzip raspios-buster-armhf-lite.zip
* Download & Start balenaEtcher-Portable.exe
* Etcher: flash from ... 2021-03-04-raspios-buster-armhf-lite.img
* Etcher: select target ... F: (SD-Karte 8GB .. 32GB)
* Etcher: flash button
* Kopieren: ssh (leer), wpa_supplicant.conf nach F:\

*wpa_supplicant.conf*

```
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=DE

network={
  ssid="WLAN-Name"
  psk="WLAN-Passwort"
  key_mgmt=WPA-PSK
  scan_ssid=1
}
```

In wpa_supplicant.conf werden die Zugangsdaten für das WiFi-Netzwerk hinterlegt.
Die leere Datei ssh startet den SSH-Dienst für den Login mit Putty.

**Login SSH**

* Download Putty.exe
* Putty: Host Name = raspberrypi (oder IP-Adresse 192.168.0.xxx)
* Putty: Connection Type = SSH
* Putty: Button Open
* Putty: login as = pi
* Putty: pi@raspberrypi's password: raspberry
