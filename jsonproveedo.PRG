LOCAL loArea

loArea = SELECT()

LOCAL lnFileHandle && numeric file handle

lnFileHandle = FCREATE( "proveedo.json")

IF lnFileHandle < 0
   && error, could not open the file
   && do something to handle the error
*   MESSAGE "Unable to create JSON file"
   RETURN

ENDIF

SELECT 0
USE PROVEEDO order tag CODIGO
SET FILTER TO WEBCOMP
GO top
*SCATTER MEMVAR

LOCAL lcLine && define a variable to hold each line

GO top
SCAN
	lcLine = "{" + CHR(13) 
	
	FWRITE(lnFileHandle, lcLine)
	
	lcLine = CHR(9) + CHR(34) + "codigo" + CHR(34) + CHR(58) +  CHR(9) + STR(CODIGO) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)
	
	lcLine = ALLTRIM(STRTRAN(ALLTRIM(NOMBRE),CHR(34),"")) && "
	lcLine = ALLTRIM(STRTRAN(lcLine,CHR(39),"")) && '
	lcLine = ALLTRIM(STRTRAN(lcLine,CHR(96),"")) && ´
	lcLine = ALLTRIM(STRTRAN(lcLine,CHR(94),"")) && ^
	lcLine = CHR(9) + CHR(34) +  "nombre" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + lcLine + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = ALLTRIM(STRTRAN(ALLTRIM(DOMICILIO),CHR(34),"")) && "
	lcLine = ALLTRIM(STRTRAN(lcLine,CHR(39),"")) && '
	lcLine = ALLTRIM(STRTRAN(lcLine,CHR(96),"")) && ´
	lcLine = ALLTRIM(STRTRAN(lcLine,CHR(94),"")) && ^
	lcLine = CHR(9) + CHR(34) +  "domicilio" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + lcLine + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) + "c_postal" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + ALLTRIM(C_POSTAL) + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)
	
	lcLine = CHR(9) + CHR(34) +  "localidad" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + ALLTRIM(LOCALIDAD) + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) +  "provincia" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + ALLTRIM(PROVINCIA) + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) +  "pais" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + ALLTRIM(PAIS) + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	IF ALLTRIM(UPPER(PAIS)) = "ARGENTINA"
		lcLine = CHR(9) + CHR(34) +  "CUIT" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + ALLTRIM(STR(CUIT,15)) + CHR(34) + CHR(44) + CHR(13)

		FWRITE(lnFileHandle, lcLine)

	ENDIF

	lcLine = CHR(9) + CHR(34) + "desempeno" + CHR(34) + CHR(58) +  CHR(9) + STR(DESEMPENO) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)
	
	strDate = ""
	IF !EMPTY(U_FACTURA)
	
		strDate = ALLTRIM(STR(YEAR(U_FACTURA))) + "-" + PADL(ALLTRIM(STR(MONTH(U_FACTURA))),2,"0") + "-" + PADL(ALLTRIM(STR(DAY(U_FACTURA))),2,"0")
	
	ELSE 

	ENDIF 
	
	lcLine = CHR(9) + CHR(34) +  "ultcompra" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + strDate + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) +  "activo" + CHR(34) + CHR(58) +  CHR(9) + "true" + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = "}" + CHR(13) 
	
	FWRITE(lnFileHandle, lcLine)

ENDSCAN

FCLOSE( lnFileHandle) && don't forget to close the file

date_now=DATETIME()
timenow=".\JSONBACK\proveedo_" + DTOS(date_now)+PADL(HOUR(date_Now),2,"0")+PADL(minute(DATETIME()),2,"0")+PADL(SEC(DATETIME()),2,"0") + ".json"

COPY FILE ("proveedo.json") TO ("\\192.168.63.23\web\proveedo.json")
COPY FILE ("proveedo.json") TO (timenow)

SELECT PROVEEDO
USE

SELECT(loArea)

RETURN && done