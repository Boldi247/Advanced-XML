(:
Ebben a feladatban az 'EPMA0000001499' id-val rendelkező Star Trek epizódban szereplő
California születésű színészek/performerek legfontosabb adatait jelenítem meg XML
formátumban (név, születési dátum, nem). Fontos továbbá, hogy csak azon színészek adatait
listázom, amelyeknek ismert a szöletési dátuma.
A lekérdezés úgy van elkészítve, hogy az egy olyan XML dokumentumot készítsen, melyben két külön csoportban
(férfiak és nők) kerülnek listázásra a színészek. Amennyiben valamely paramétere változna a lekérdezésnek (pl a születési hely),
és csak nőt/férfit, vagy egyiket sem találna, akkor nem kerül létrehozásra a <malePerformers/> / <femalePerformers /> XML tag.
:)

xquery version "3.1";

import schema default element namespace "" at "born_in_california_schema.xsd";

declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "xml";
declare option output:html-version "5.0";
declare option output:indent "yes";

let $episodeJSON := fn:json-doc("../episode_EPMA0000001499.json")
let $performersCalifornia := $episodeJSON?episode?performers?*[fn:contains(?placeOfBirth, "California")][fn:exists(?dateOfBirth)]

let $malePerformers :=
    for $performer in $performersCalifornia
    where $performer?gender = "M"
    return
        <person>
            <name>{data($performer?name)}</name>
            <dateOfBirth>{data($performer?dateOfBirth)}</dateOfBirth>
            <gender>{data($performer?gender)}</gender>
        </person>

let $femalePerformers :=
    for $performer in $performersCalifornia
    where $performer?gender = "F"
    return
        <person>
            <name>{data($performer?name)}</name>
            <dateOfBirth>{data($performer?dateOfBirth)}</dateOfBirth>
            <gender>{data($performer?gender)}</gender>
        </person>

return validate { document {
    <performers>
        {if (exists($malePerformers)) then <malePerformers>{$malePerformers}</malePerformers> else ()}
        {if (exists($femalePerformers)) then <femalePerformers>{$femalePerformers}</femalePerformers> else ()}
    </performers>
}}