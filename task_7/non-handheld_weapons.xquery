(:
Ebben a feladatban egy JSON formátumú, egyszerű
string értékekkel feltöltött listát hozok létre, melyben a
Star Trek-ben szereplő nem kézi fegyverek nevei találhatóak
A lekérdezés bemenete a fegyverek listájának első oldala, azaz
az első 100 rekord.
:)

xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "json";
declare option output:html-version "5.0";
declare option output:indent "yes";

let $weaponsJSON := fn:json-doc("../weapons.json")
return array {
    $weaponsJSON?weapons?*[?handHeldWeapon = fn:false()]?name => fn:sort()
}