(:
Ebben a felladatban egy olyan JSON tömböt hozok létre, melyben
az olyan Star Trek epizódok címe, illetve "játszódási évei" szerepelnek,
melyek újévkor játszódtak, azaz: a rész kezdetén az év nem egyezik meg a rész végi évvel.
A feladat bemenete a Strar Trek API epizódjainak első oldala, azaz az első 100 rekord.
:)

xquery version "3.1";

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:html-version "5.0";
declare option output:indent "yes";

let $episodesJSON := fn:json-doc("../episodes.json"),
    $episodesNewYear := $episodesJSON?episodes?*[?yearFrom != ?yearTo]
return map:merge(for $episode in $episodesNewYear return map:entry($episode?title, $episode?yearFrom || "-" || $episode?yearTo))