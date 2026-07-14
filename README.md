# kandidierendencheck – interaktive Landingpage

Eine interaktive Scrollytelling-Landingpage für den **Kandidierendencheck**
(ein Projekt von [abgeordnetenwatch.de](https://www.abgeordnetenwatch.de)).

Die Seite erzählt in sechs Szenen den Bogen von „ich check das nicht" zu
„ich check das jetzt": Aus einem chaotischen Haufen aus Wahlzettel,
Kandidat:innen und Themenkarten wird beim vertikalen Scrollen Stück für Stück
Klarheit – Karten fliegen rein und raus, der Wahlzettel schiebt sich in den
Vordergrund, am Ende steht das aufgeräumte Produkt.

## Live-Demo

**https://lenariegerabgeordnetenwatch.codeberg.page/kandidierendencheck/**

Gehostet über [Codeberg Pages](https://codeberg.page) (Branch `pages`).

## Lokal starten

Die Seite ist statisch (eine `index.html` + `assets/`), lädt die Bilder aber
über relative Pfade – daher am besten über einen kleinen lokalen Server öffnen:

```bash
python3 -m http.server 8777
# dann http://localhost:8777 öffnen
```

## Aufbau

```
index.html        # gesamte Seite: HTML, CSS und die Scroll-Engine (Vanilla JS)
assets/
  candidates/     # freigestellte Kandidat:innen
  thesis/         # Themen-/Thesenkarten (Fotos + Titel)
  ui/             # Produkt-Screens (Swipe-Karte, Ergebnisliste, Handy)
  ballot-orig.png # Stimmzettel
  bg-collage.png  # Bundesland-Outline (Hintergrund)
```

## Technik

Kein Build-Schritt, keine Abhängigkeiten. Eine persistente „Bühne" mit
geteilten Elementen, die beim Scrollen zwischen ihren Positionen pro Szene
interpolieren (scroll-driven Keyframes), plus CSS-`scroll-snap` zwischen den
Szenen. **Keine externen Requests:** Die Schrift *Outfit* ist selbst gehostet (`assets/fonts/`, woff2) – Google Fonts wird nicht geladen.

## Lizenz

- **Code** (`index.html`, Styles, Scroll-Engine): [MIT](LICENSE)
- **Medien** (Bilder in `assets/`): Creative Commons – je nach Quelle unter der
  jeweiligen CC-Lizenz, **nicht** unter MIT. Bei Weiterverwendung bitte die
  jeweilige Lizenz/Namensnennung beachten.

## Credits

Design & Konzept: Kandidierendencheck / abgeordnetenwatch.de
