(:
Ebben a feladatban egy XML dokumentumot állítok elő (./output.xml).
A dokumentum a Star Trekben használt fegyverek kategóriáit térképezi fel, illetve összeszámolja,
hogy melyik kategóriából hány darab fegyver ismert.
A lekérdezés bemenete az API első oldala => 1. 100 elem
:)

xquery version "3.1";

import schema default element namespace "" at "./weapon_categories_schema.xsd";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";
declare namespace array = "http://www.w3.org/2005/xpath-functions/array";

declare option output:method "xml";
declare option output:html-version "5.0";
declare option output:indent "yes";

let $weaponsJSON := fn:json-doc("../weapons.json")
let $weapons := $weaponsJSON?weapons?*
let $weaponCategoriesAllOccurrences :=
    for $weapon in $weapons
    let $categories :=
        for $key in map:keys($weapon)
        where contains($key, "Weapon") and $weapon($key) = true()
        return string($key)
    return $categories
let $distinctValues := fn:distinct-values($weaponCategoriesAllOccurrences)
let $categoriesArray :=
    for $category in $distinctValues
    let $numberOfWeapons :=
        count(
            for $occurrence in $weaponCategoriesAllOccurrences
            where $occurrence = $category
            return $occurrence
        )
    return
        <category categoryName="{$category}" numberOfWeapons="{$numberOfWeapons}" />

return validate { document {
    <categories>
        {$categoriesArray}
    </categories>
}}
