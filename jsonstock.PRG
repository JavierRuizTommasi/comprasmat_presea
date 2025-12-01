LOCAL loArea

loArea = SELECT()

LOCAL lnFileHandle && numeric file handle
LOCAL posDes, posHas

lnFileHandle = FCREATE( "stock.json")
*lnFileHandle = FOPEN( "C:\Users\Javier\Downloads\Proagro\CRM5.txt")

IF lnFileHandle < 0
   && error, could not open the file
   && do something to handle the error
*   MESSAGE "Unable to create JSON file"
   RETURN

ENDIF

SELECT 0
USE STOCK ALIAS STOCK order tag STOCK
SET FILTER TO WEBCOMP
GO top
*SCATTER MEMVAR

LOCAL lcLine && define a variable to hold each line
*lcLine = FGETS( lnFileHandle) && lee loa encabezados

*m.lastcod = 0
*m.yaleido = 0

GO top
SCAN
	lcLine = "{" + CHR(13) 
	
	FWRITE(lnFileHandle, lcLine)
	
	lcLine = CHR(9) + CHR(34) + "codigo" + CHR(34) + CHR(58) +  CHR(9) + STR(CODIGO) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)
	
	lcLine = CHR(9) + CHR(34) +  "descrip" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + ALLTRIM(DETALLE) + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) +  "rubro" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + ALLTRIM(RUBRO) + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) +  "subrubro" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + ALLTRIM(SUBRUBRO) + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) +  "detaeng" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + ALLTRIM(DETAENG) + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) +  "rubroeng" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + ALLTRIM(RUBROENG) + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) +  "subrubeng" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + ALLTRIM(SUBRUBENG) + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	DO CASE
		CASE ALLTRIM(UNI_MEDIDA) = "01" 
			strUnidad = "KG"
		CASE ALLTRIM(UNI_MEDIDA) = "05" 
			strUnidad = "LT"
		CASE ALLTRIM(UNI_MEDIDA) = "07" 
			strUnidad = "UN"
		CASE ALLTRIM(UNI_MEDIDA) = "02" 
			strUnidad = "MT"
		OTHERWISE 
			strUnidad = "UN"
	ENDCASE 
	 			
	lcLine = CHR(9) + CHR(34) +  "unidad" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + strUnidad + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) +  "costo" + CHR(34) + CHR(58) +  CHR(9) + STR(ULT_COSTO) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) +  "historico" + CHR(34) + CHR(58) +  CHR(9) + STR(ULT_COSTO) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) +  "rankcontrib" + CHR(34) + CHR(58) +  CHR(9) + STR(RANKCONTRI) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

*!*	 	lnLines = ALINES( aCaract, CARACTERIS, 1 )
*!*	    lcOutStr = "[{" + CHR(13) 
*!*	    IF !EMPTY(aCaract[1]) 
*!*			FOR lnLCount = 1 TO lnLines
*!*			    linea = aCaract[ lnLCount ]
*!*				linea = ALLTRIM(STRTRAN(linea,CHR(9),""))
*!*				linea = ALLTRIM(STRTRAN(linea ,CHR(34),""))
*!*				linea = ALLTRIM(STRTRAN(linea ,CHR(39),""))
*!*				lcOutStr = lcOutStr + CHR(9) + CHR(34) + "linea" + CHR(34) + CHR(58) + CHR(34) + linea + CHR(34) + IIF(lnlines=lnLCount,"",CHR(44)) + CHR(13) 
*!*			NEXT
*!*		ENDIF 
*!*		lcOutStr = lcOutStr + "}]"
*!*		lcLine = CHR(9) + CHR(34) +  "caracteris" + CHR(34) + CHR(58) +  CHR(9) + lcOutStr + CHR(44) + CHR(13)
	
	strChar = ALLTRIM(STRTRAN(CARACTERIS,CHR(13),"<BR>"))
	strChar = ALLTRIM(STRTRAN(strChar,CHR(10),"<BR>"))
	strChar = ALLTRIM(STRTRAN(strChar,CHR(9),""))
	strChar = ALLTRIM(STRTRAN(strChar,CHR(34),""))
	strChar = ALLTRIM(STRTRAN(strChar,CHR(39),""))
	strChar = ALLTRIM(STRTRAN(strChar,"á","&aacute;")) && á
	strChar = ALLTRIM(STRTRAN(strChar,"é","&eacute;")) && é
	strChar = ALLTRIM(STRTRAN(strChar,"í","&iacute;")) && í
	strChar = ALLTRIM(STRTRAN(strChar,"ó","&oacute;")) && ó
	strChar = ALLTRIM(STRTRAN(strChar,"ú","&uacute;")) && ú
	strChar = ALLTRIM(STRTRAN(strChar,"ñ","&ntilde;")) && ñ
	strChar = ALLTRIM(STRTRAN(strChar,"ü","&uuml;"))	&& ü
	strChar = ALLTRIM(STRTRAN(strChar,"¿","&iquest;"))	&& ¿
	strChar = ALLTRIM(STRTRAN(strChar,"¡","&iexcl;"))	&& ¿
	
	lcLine = CHR(9) + CHR(34) +  "caracteris" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + strChar + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	strChar = ALLTRIM(STRTRAN(CARACTERIS,CHR(13),"<BR>"))
	strChar = ALLTRIM(STRTRAN(strChar,CHR(10),"<BR>"))
	strChar = ALLTRIM(STRTRAN(strChar,CHR(9),""))
	strChar = ALLTRIM(STRTRAN(strChar,CHR(34),""))
	strChar = ALLTRIM(STRTRAN(strChar,CHR(39),""))
	lcLine = CHR(9) + CHR(34) +  "caracteriseng" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + strChar + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) +  "link" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + SUBSTR(link,AT("http",link)) + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) +  "activo" + CHR(34) + CHR(58) +  CHR(9) + "true" + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = "}" + CHR(13) 
	
	FWRITE(lnFileHandle, lcLine)

ENDSCAN

FCLOSE( lnFileHandle) && don't forget to close the file

SELECT STOCK
USE

date_now = DATETIME()
timenow = ".\JSONBACK\stock_" + DTOS(date_now)+PADL(HOUR(date_Now),2,"0")+PADL(minute(DATETIME()),2,"0")+PADL(SEC(DATETIME()),2,"0") + ".json"

COPY FILE ("stock.json") TO ("\\192.168.63.23\web\stock.json")
COPY FILE ("stock.json") TO (timenow)

SELECT(loArea)

RETURN && done