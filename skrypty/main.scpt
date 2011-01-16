--Licencja MIT
--autor: Michał Gołębiowski
--
--TODO:
--Zmienić przetrzymywanie hasła na KeyChain
--Przenieść wszystko na AppleScriptObjC


--Po dwukliku na program
set login to text returned of (display dialog "Wprowadź Login" default answer "")
set pas to text returned of (display dialog "Wprowadź Hasło" default answer "" with hidden answer)
--zapisywanie hasla
do shell script "cd " & loginFileP & " && echo " & login & ":" & pas & " > login.txt"


--plik naniesiony na ikone
on open myFile
	
	tell application "Finder"
		--loginFile: path do pakietu; loginFileP: path z 'ukosnikami'
		set loginFile to (path to me) as text
		set loginFileP to (POSIX path of file loginFile) as text
		set l0g to "login.txt"
		--sprawdzamy czy plik z hslem istnieje
		if exists (loginFile & l0g) then
			set myimg to (POSIX path of file (item 1 of myFile)) --pierwszy przeniesiony plik
			set mytext to text returned of (display dialog "Wprowadź tekst" default answer "")
			set prefsContents to (do shell script "cd " & (POSIX path of (path to me)) & " && cat login.txt") --z pliku pobieramy passy i dajemy do zmienej
			do shell script "cd ~/ && curl -v -H'Accept: application/json' -H'X-Blip-Application: PicToBlip' -H'X-Blip-api: 0.02' -u " & prefsContents & " -F 'update[body]=" & mytext & "' -F 'update[picture]=@" & myimg & "' http://api.blip.pl/updates" --Prosto z przykładu na blipapi.wikidot.com
		else
			--
			--pierwsze uruchomienie
			set login to text returned of (display dialog "Wprowadź Login" default answer "")
			set pas to text returned of (display dialog "Wprowadź Hasło" default answer "" with hidden answer)
			--zapisywanie hasla
			do shell script "cd " & loginFileP & " && echo " & login & ":" & pas & " > login.txt"
			
			--teraz wysyłamy status
			
			set myimg to (POSIX path of file (item 1 of myFile))
			set mytext to text returned of (display dialog "Wprowadź tekst" default answer "")
			set prefsContents to (do shell script "cd " & (POSIX path of (path to me)) & " && cat login.txt")
			do shell script "cd ~/ && curl -v -H'Accept: application/json' -H'X-Blip-Application: PicToBlip' -H'X-Blip-api: 0.02' -u " & prefsContents & " -F 'update[body]=" & mytext & "' -F 'update[picture]=@" & myimg & "' http://api.blip.pl/updates" --Prosto z przykładu na blipapi.wikidot.com
			
		end if
		
	end tell
end open