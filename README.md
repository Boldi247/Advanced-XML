# Fejlett XML technológiák beadandó dolgozat

Ez a projekt a fejlett XML technológiák kurzusára készült.
Készítette: Kovács Boldizsár József (2023. december)
A projek lekérdezéseihez a [Star Trek API](https://stapi.co/)-t használtam.
Annak érdekében, hogy a lekérdezések gyorsabban lefussanak, az API request response-okat elmentettem, ezek adják a lekérdezések alapját. Ezek a fájlok megtalálhatóak a projekt gyökérkönyvtárában:

- episode_EPMA0000001499.json
- episodes.json
- weapons.json

Ezek a requestek paginálhatóak (az episode_EPMA0000001499.json kivételével), a projektben ezekből az első egy oldalnyi adatot (azaz 100 rekordot) használom a lekérdezésekhez.

## 1. feladat

Ebben a feladatban azt vizsgálom, hogy mely fegyver (vagy fegyverek) neve a leghosszabb. Egy XML dokumentum az output.

## 2. feladat

Ebben a feladatban egy JSON tömböt hozok létre (./output.json), melynek elemei objektumok:
Az objektumok azon epizódok legfontosabb adatait tartalmazzák (epizód név, amerikai sugárzási dátum, azonosító)
melyek 1968. 01. 01 után kerültek vetítésre.

## 3. feladat

Ebben a feladatban egy JSON tömböt állítok elő (./output.json), melynek elemei objektumok, melyek tartalmazzák az 'EPMA0000001499' azonosítójú Star Trek epizód olyan szereplőinek adatait (karakter azon., születési év, halálozási év, név, életének időtartama években), akik születési és halálozási ideje is ismert a sorozatban, és legalább 30 évet élnek/éltek

## 4. feladat

Ebben a feladatban egy XML dokumentumot állítok elő (./output.xml).
A dokumentum a Star Trekben használt fegyverek kategóriáit térképezi fel, illetve összeszámolja, hogy melyik kategóriából hány darab fegyver ismert.
A lekérdezés bemenete az API első oldala => 1. 100 elem

## 5. feladat

Ebben a feladatban az 'EPMA0000001499' id-val rendelkező Star Trek epizód színeit listázom ki, megjelenítve a színészi pozíciójukat is.
A program végrehajtása egy bootsrap segítségével stilizált HTML állományt generál, melyben táblázatban jelölnek meg az imént említett adatok.

## 6. feladat

Ebben a feladatban egy XML dokumentumot állítok elő.
A dokumentumban azon színészek (!AKIK AZ 'EPMA0000001499' EPIZÓDBAN SZEREPTELTEK!) neve illetve színészi kategóriájuk található meg, akik csak egyetlen színészi kategóriába tartoznak.

## 7. feladat

Ebben a feladatban egy JSON formátumú, egyszerű string értékekkel feltöltött listát hozok létre, melyben a Star Trek-ben szereplő nem kézi fegyverek nevei találhatóak. A lekérdezés bemenete a fegyverek listájának első oldala, azaz az első 100 rekord.

## 8. feladat

Ebben a felladatban egy olyan JSON tömböt hozok létre, melyben az olyan Star Trek epizódok címe, illetve "játszódási évei" szerepelnek, melyek újévkor játszódtak, azaz: a rész kezdetén az év nem egyezik meg a rész végi évvel.
A feladat bemenete a Strar Trek API epizódjainak első oldala, azaz az első 100 rekord.

## 9. feladat

Ebben a feladatban az 'EPMA0000001499' id-val rendelkező Star Trek epizódban szereplő californiai születésű színészek/performerek legfontosabb adatait jelenítem meg XML formátumban (név, születési dátum, nem). Fontos továbbá, hogy csak azon színészek adatait listázom, amelyeknek ismert a szöletési dátuma.
A lekérdezés úgy van elkészítve, hogy az egy olyan XML dokumentumot készítsen, melyben két külön csoportban (férfiak és nők) kerülnek listázásra a színészek. Amennyiben valamely paramétere változna a lekérdezésnek (pl a születési hely), és csak nőt/férfit, vagy egyiket sem találna, akkor nem kerül létrehozásra a `<malePerformers/> ` és ` <femalePerformers />` XML tag.

## 10. feladat

Ebben a feladatban egy JSON objektumot állítok elő, melyben a Star Trek API-ban található epizódokra alkalmazok szűrést, annak érdekében, hogy az összes olyan epizódot kilistázzam, amelyeknek mint az eredeti (angol) címe, illetve a többi nyelven ismert címe is MAXIMUM 1 szóból áll (értve ezt úgy, hogy amennyiben nem ismert egy adott másik nyelven a címe, de amiben ismert,
ott egy szóból áll, akkor az belekerül a listába).
