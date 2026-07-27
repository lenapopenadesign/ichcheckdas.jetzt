# Deployment auf Uberspace (Mainz, DE)

Statische Seite (`index.html` + `assets/`). Kein Build nötig – Dateien werden nach
`~/html` auf Uberspace gespiegelt. HTTPS macht Uberspace automatisch (Let's Encrypt).

## 1. Uberspace-Account anlegen
1. Auf <https://uberspace.de/> registrieren (Benutzername frei wählbar, z. B. `awkc`).
   → Uberspace ist „pay what you want", 30 Tage kostenlos zum Testen.
2. Nach der Registrierung notieren:
   - **Username** (z. B. `awkc`)
   - **SSH-Host**: `<username>.uber.space` (z. B. `awkc.uber.space`)

## 2. SSH einrichten (passwortloses Deploy)
Auf deinem Mac deinen öffentlichen Key auf Uberspace hinterlegen:
```bash
ssh-copy-id <username>@<username>.uber.space
```
(Alternativ den Public Key `~/.ssh/id_ed25519.pub` im Uberspace-Dashboard eintragen.)
Danach testen:
```bash
ssh <username>@<username>.uber.space "echo ok"
```

## 3. Domain auf Uberspace anmelden
Per SSH einloggen und beide Domains hinzufügen:
```bash
ssh <username>@<username>.uber.space
uberspace web domain add ichcheckdas.jetzt
uberspace web domain add www.ichcheckdas.jetzt
```
Der Befehl gibt **die genauen DNS-Records aus**, die du bei INWX setzen musst
(eine IPv4 = `A`, eine IPv6 = `AAAA`). Notiere sie.

## 4. DNS bei INWX umstellen
Bei INWX (Domain `ichcheckdas.jetzt`) die **alten Codeberg-Records ersetzen**:

Entfernen (alt, Codeberg):
- `A  @  217.197.84.141`
- `AAAA  @  2a0a:4580:103f:c0de::2`
- dieselben für `www`
- TXT `_git-pages-repository...` (Codeberg-spezifisch, nicht mehr nötig)

Neu setzen (Werte aus Schritt 3):
- `A     @    <IPv4 von Uberspace>`
- `AAAA  @    <IPv6 von Uberspace>`
- `A     www  <IPv4 von Uberspace>`
- `AAAA  www  <IPv6 von Uberspace>`

> Tipp: INWX loggt schnell aus – die Records zügig am Stück eintragen.

## 5. Seite hochladen
Im Projektordner (`landingpage/`):
```bash
UBERSPACE_USER=<username> ./deploy.sh
```
Das spiegelt die Seite nach `~/html` (ohne `.git`, `deploy.sh`, `_oggen.html` usw.).

## 6. HTTPS / Fertig
- Sobald die DNS-Records greifen, stellt Uberspace automatisch ein Let's-Encrypt-Zertifikat aus.
- Status prüfen: `uberspace web domain list`
- Aufrufen: <https://ichcheckdas.jetzt>

## Wichtig: Reihenfolge / keine Downtime
Die Live-Seite läuft noch über **Codeberg Pages**. Erst **nach** erfolgreichem
Uberspace-Deploy + funktionierendem HTTPS die DNS bei INWX umstellen – dann ist die
Umschaltung nahtlos. Codeberg-Repo erst danach löschen.

## Updates künftig
Änderungen committen/pushen (GitHub) und deployen:
```bash
git add -A && git commit -m "..." && git push
UBERSPACE_USER=<username> ./deploy.sh
```
