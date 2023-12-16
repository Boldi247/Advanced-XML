(:
Ebben a feladatban egy JSON tömböt állítok elő (./output.json), melynek elemei objektumok,
melyek tartalmazzák az 'EPMA0000001499' azonosítójú Star Trek epizód
olyan szereplőinek adatait (karakter azon., születési év, halálozási év, név, életének időtartama években),
akik születési és halálozási ideje is ismert a sorozatban, és legalább 30 évet élnek/éltek
:)

xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";

declare option output:method "json";
declare option output:html-version "5.0";
declare option output:indent "yes";

let $episodeJSON := fn:json-doc("../episode_EPMA0000001499.json"),
$charactersWithLifeLength := $episodeJSON?episode?characters?*[fn:empty(?yearOfBirth) eq false() and fn:empty(?yearOfDeath) eq false()],
$charactersLivedMoreThanThirty :=$charactersWithLifeLength[?yearOfDeath - ?yearOfBirth gt 30],
$transformedArray := array {
    for $character in $charactersLivedMoreThanThirty
        return map {
            "characterID": $character?uid,
            "name": $character?name,
            "gender": if ($character?gender = "M") then "Male" else "Female",
            "yearOfBirth": $character?yearOfBirth,
            "yearOfDeath": $character?yearOfDeath,
            "lifeInYears": $character?yearOfDeath - $character?yearOfBirth
        }
}
return $transformedArray