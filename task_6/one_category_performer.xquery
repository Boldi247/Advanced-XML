(:
Ebben a feladatban egy XML dokumentumot állítok elő.
A dokumentumban azon színészek (!AKIK AZ 'EPMA0000001499' EPIZÓDBAN SZEREPTELTEK!)
neve illetve szinészi kategóriájuk található meg, akik csak egyetlen színészi kategóriába
tartoznak.
:)

xquery version "3.1";

import schema default element namespace "" at "one_category_performer_schema.xsd";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";

declare option output:method "xml";
declare option output:html-version "5.0";
declare option output:indent "yes";

let $episodeJSON := fn:json-doc("../episode_EPMA0000001499.json")
let $performers := $episodeJSON?episode?performers?*

let $onePerformers :=
    for $performer in $performers
    let $performerCategories :=
        for $key in map:keys($performer)
        where contains($key, "Performer") and $performer($key) = true()
        return $key
    where array:size(array {$performerCategories}) = 1
    return
        <performer name="{$performer?name}" category="{$performerCategories}" />

return validate { document {
    <performers>{$onePerformers}</performers>
}}