(:
Ebben a feladatban azt vizsgálom, hogy mely fegyver (vagy fegyverek) neve a leghosszabb.
Egy XML dokumentum az output.
:)

xquery version "3.1";

import schema default element namespace "" at "longest_weapon_name_schema.xsd";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

declare option output:method "xml";
declare option output:html-version "5.0";
declare option output:indent "yes";

let $weaponsJSON := fn:json-doc("../weapons.json"),
    $maxWeaponLength := $weaponsJSON?weapons?*[?projectileWeapon] ! fn:string-length(?name) => fn:max(),
    $longestWeaponName := $weaponsJSON?weapons?*[fn:string-length(?name) eq $maxWeaponLength]?name

return
    validate {
        document {
            <weapons>
                {
                    for $weapon in $longestWeaponName return
                    <weapon>
                        <name>{$weapon}</name>
                        <nameLength>{fn:string-length($weapon)}</nameLength>
                    </weapon>
                }
            </weapons>
        }
    }