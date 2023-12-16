(:
Ebben a feladatban egy JSON tömböt hozok létre (./output.json), melynek elemei objektumok:
Az objektumok azon aepizódok legfontosabb adatait tartalmazzák (epizód név, amerikai sugárzási dátum, azonosító)
melyek 1968. 01. 01 után kerültek vetítésre
:)

xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";

declare option output:method "json";
declare option output:html-version "5.0";
declare option output:indent "yes";

let $episodesJSON := fn:json-doc("../episodes.json"),
    $episodesAfterDate := $episodesJSON?episodes?*[?series?title = "Star Trek: The Original Series"][?usAirDate gt "1968-01-01"]
return array {
    for-each($episodesAfterDate, function($episode) {
        map {
            "episodeTitle": $episode?title,
            "usAirDate": $episode?usAirDate,
            "id": $episode?uid
        }
    })
}