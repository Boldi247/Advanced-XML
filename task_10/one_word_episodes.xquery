(:
Ebben a feladatban egy JSON objektumot állítok elő, melyben a
Star Trek API-ban található epizódokra alkalmazok szűrést, annak
érdekében, hogy az összes olyan epizódot kilistázzam, amelyeknek mint az
eredeti (angol) címe, illetve a többi nyelven ismert címe is MAXIMUM 1 szóból áll
(értve ezt úgy, hogy amennyiben nem ismert egy adott másik nyelven a címe, de amiben ismert,
ott egy szóból áll, akkor az belekerül a listába).
:)

xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:html-version "5.0";
declare option output:indent "yes";

let $episodes := fn:json-doc("../episodes.json")?episodes?*,

$oneWordEpisodes :=
    array {
    $episodes[
        ?series?title eq "Star Trek: Voyager" and
        not(fn:contains(?title, " ")) and
        not(fn:contains(?titleGerman, " ")) and
        not(fn:contains(?titleJapanese, " ")) and
        not(fn:contains(?titleItalian, " "))
    ]}

return $oneWordEpisodes
