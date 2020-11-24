# Script pour combiner naf oaf et wav d'EVA2

form Fulfilling Amper requirements
	sentence Folder 	
endform

# creer la liste des fichiers wav dans un repertoire

liste_fichierswav = Create Strings as file list: "list", folder$ + "*wa1.wav"
liste_fichiersnaf = Create Strings as file list: "list", folder$ + "*naf.wav"
liste_fichiersoaf = Create Strings as file list: "list", folder$ + "*oaf.wav"

nombreDeFichiers = Get number of strings

for ifichier from 1 to nombreDeFichiers
	selectObject: liste_fichierswav
	nomDuFichierwav$ = Get string: ifichier  
	selectObject: liste_fichiersnaf
	nomDuFichiernaf$ = Get string: ifichier   
	selectObject: liste_fichiersoaf
	nomDuFichieroaf$ = Get string: ifichier   
	# important to read oaf first, the select plus plus processu doesn't matter
	sonwav = Read from file: folder$ + nomDuFichierwav$
   	sonoaf = Read from file: folder$ + nomDuFichieroaf$ 
   	sonnaf = Read from file: folder$ + nomDuFichiernaf$ 
   	selectObject: sonwav
   	newsonwav = Resample: 6250, 50
    	selectObject: sonnaf
    	plusObject: sonoaf
    	plusObject: newsonwav
    	finalsound = Combine to stereo
# prevent Praat from issuing warning messages
    	nowarn Write to WAV file: folder$ + nomDuFichierwav$ - ".wav"+"stereo.wav" 
    	selectObject: sonwav
    	plusObject: sonnaf
    	plusObject: sonoaf
		plusObject: newsonwav
    	plusObject: finalsound
    	Remove
endfor