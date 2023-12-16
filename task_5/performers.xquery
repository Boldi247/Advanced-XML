(:
Ebben a feladatban az 'EPMA0000001499' id-val rendelkező Star Trek epizód színeit listázom ki,
Megejelnítve a színészi pozíciójukat is.
A program végrehajtása egy bootsrap segítségével stilizált HTML állományt generál,
melyben táblázatban jelölnek meg az imént említett adatok.
:)

xquery version "3.1";

declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";
declare namespace map = "http://www.w3.org/2005/xpath-functions/map";

declare option output:method "html";
declare option output:html-version "5.0";
declare option output:indent "yes";

let $episodeJSON := fn:json-doc("../episode_EPMA0000001499.json"),
$performers := $episodeJSON?episode?performers?*,
$performerCategories := for $performer in $performers return
map{"name": $performer?name , "categories": map:for-each($performer, function($key, $value) {
    if (contains($key, "Performer") and $value = true())
    then $key
    else ()
  })}
  
return document {
    <html lang="en">
        <head>
            <title>5. feladat</title>
            <meta charset="utf-8"/>
            <meta name="viewport" content="width=device-width, initial-scale=1"/>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous" />
            <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.7/dist/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        </head>
        <body>
            <div class="table-responsive">
                <table class="table align-middle table-striped table-bordered">
                    <h1 class="text-center">A szineszek listaja a szineszi poziciojukkal parositva</h1>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Szinesz neve</th>
                            <th>Szineszi pozicio(k)</th>
                        </tr>
                    </thead>
                    <tbody class="table-group-divider">
                        {
                            for $entry in $performerCategories
                            count $i
                            return
                                <tr>
                                    <td>{$i}</td>
                                    <td>{$entry?name}</td>
                                    <td>{for $listItem in $entry?categories return <li>{$listItem}</li>}</td>
                                </tr>
                        }
                    </tbody>
                </table>
            </div>
        </body>
    </html>
}