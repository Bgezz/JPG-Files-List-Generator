# Script: list_jpg_files_with_yearly_dropdown.ps1
# Cél: Listázza az összes JPG fájlt a megadott meghajtón és mappákban, és mentse ki azokat egy HTML fájlba, valamint készítsen statisztikákat és összegzéseket évek szerinti legördülő menüvel
# Miért: Az évek szerinti csoportosítás lehetővé teszi a könnyű navigációt az évek között, és megkönnyíti a felhasználók számára a kívánt évek fájljainak kiválasztását

# Megadott meghajtó betűjele
$driveLetter = "C:"

# HTML fájl elérési útvonala
$htmlFilePath = "$([Environment]::GetFolderPath('Desktop'))\jpg_files_with_yearly_dropdown.html"

# Függvény a JPG fájlok listázásához és HTML fájlba mentéséhez évek szerinti legördülő menüvel
function ListJpgFilesToHtmlWithYearlyDropdown {
    param([string]$path, [string]$htmlFilePath)

    # Ellenőrzi a könyvtár létezését
    if (-not (Test-Path $path -PathType Container)) {
        Write-Host "Hiba: A(z) $path könyvtár nem létezik."
        return
    }

    # Lekéri az összes JPG fájlt
    $jpgFiles = Get-ChildItem -Path $path -Filter *.jpg -File -Recurse

    # Csoportosítja az éveket és eltávolítja a duplikációkat
    $years = $jpgFiles | ForEach-Object { $_.LastWriteTime.Year } | Select-Object -Unique

    # Létrehozza a legördülő menüt az évek szerint
    $dropdownMenu = "<select id='yearDropdown' onchange='filterByYear()'><option value='all'>All Years</option>"
    foreach ($year in $years) {
        $dropdownMenu += "<option value='$year'>$year</option>"
    }
    $dropdownMenu += "</select>"

    # Létrehoz egy HTML táblázatot a JPG fájlok nevével és módosítási dátumával
    $htmlTable = "<html><head><title>JPG Files</title>"
    $htmlTable += "<script>function filterByYear() { var year = document.getElementById('yearDropdown').value; var rows = document.querySelectorAll('tr'); rows.forEach(function(row) { if (year == 'all' || row.children[1].innerHTML.includes(year)) { row.style.display = 'table-row'; } else { row.style.display = 'none'; } }); }</script>"
    $htmlTable += "</head><body><h1>JPG Files</h1>$dropdownMenu<table><tr><th>File Name</th><th>Last Modified</th></tr>"
    foreach ($file in $jpgFiles) {
        $htmlTable += "<tr><td>$($file.Name)</td><td>$($file.LastWriteTime.Year)</td></tr>"
    }
    $htmlTable += "</table></body></html>"

    # HTML táblázat mentése fájlba
    $htmlTable | Out-File -FilePath $htmlFilePath
}

# Futtatja a függvényt a megadott meghajtón
ListJpgFilesToHtmlWithYearlyDropdown -path $driveLetter -htmlFilePath $htmlFilePath
