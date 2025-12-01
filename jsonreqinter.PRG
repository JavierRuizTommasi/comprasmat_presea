SET DATE TO FRENCH
SET CENTURY ON
SET ENGINEBEHAVIOR 70

LOCAL loArea

loArea = SELECT()

LOCAL lnFileHandle && numeric file handle

lnFileHandle = FCREATE( "reqinter.json")

IF lnFileHandle < 0
   && error, could not open the file
   && do something to handle the error
*   MESSAGE "Unable to create JSON file"
   RETURN

ENDIF

LOCAL strSql as String
strSql = "SELECT NUMERO, FECHA, FINALIZA, CODIGO, DETALLE, UNI_MEDIDA, PRECIO, "
strSql = strSql + "CANTIDAD, CANT_CANCE, SUGERIDA, ULT_COSTO, "
strSql = strSql + "LICITACION, MONEDA, COTIZACION, PROVEEDOR, ULT_PROVEE, EMPRESA, ID "
strSql = strSql + "FROM REQTOWEB "
strSql = strSql + "WHERE OK "
strSql = strSql + ".AND. !WEBCOMP "
strSql = strSql + "INTO CURSOR MYREQIN READWRITE"
&strSql

SELECT MYREQIN
GO top
*SCATTER MEMVAR

LOCAL lcLine && define a variable to hold each line

vacio = .T.

GO top
SCAN
	vacio = .F.
	lcLine = "{" + CHR(13) 
	
	FWRITE(lnFileHandle, lcLine)
	
	lcLine = CHR(9) + CHR(34) + "licitacion" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + ALLTRIM(LICITACION) + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)
	
	strDate = ""
	IF !EMPTY(FECHA)
		strDate = ALLTRIM(STR(YEAR(FECHA))) + "-" + PADL(ALLTRIM(STR(MONTH(FECHA))),2,"0") + "-" + PADL(ALLTRIM(STR(DAY(FECHA))),2,"0")
	ENDIF 
	
	lcLine = CHR(9) + CHR(34) +  "fecha" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + strDate + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	strDate = ""
	IF !EMPTY(FINALIZA)
		strDate = ALLTRIM(STR(YEAR(FINALIZA))) + "-" + PADL(ALLTRIM(STR(MONTH(FINALIZA))),2,"0") + "-" + PADL(ALLTRIM(STR(DAY(FINALIZA))),2,"0")
	ENDIF 
	
	lcLine = CHR(9) + CHR(34) +  "finaliza" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + strDate + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) + "producto" + CHR(34) + CHR(58) +  CHR(9) + ALLTRIM(STR(CODIGO)) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)
	
	lcLine = ALLTRIM(STRTRAN(ALLTRIM(DETALLE),CHR(34),"")) && "
	lcLine = ALLTRIM(STRTRAN(lcLine,CHR(39),"")) && '
	lcLine = ALLTRIM(STRTRAN(lcLine,CHR(96),"")) && ´
	lcLine = ALLTRIM(STRTRAN(lcLine,CHR(94),"")) && ^
	lcLine = CHR(9) + CHR(34) +  "descrip" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + lcLine + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) + "cantidad" + CHR(34) + CHR(58) +  CHR(9) + STR(CANTIDAD,15,5) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)
	
	lcLine = CHR(9) + CHR(34) + "sugerida" + CHR(34) + CHR(58) +  CHR(9) + STR(SUGERIDA,15,5) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)
	
	strUnidad = ""
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

	lcLine = CHR(9) + CHR(34) + "costo" + CHR(34) + CHR(58) +  CHR(9) + STR(PRECIO,15,5) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) + "historico" + CHR(34) + CHR(58) +  CHR(9) + STR(ULT_COSTO,15,5) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) + "proveedor" + CHR(34) + CHR(58) +  CHR(9) + ALLTRIM(STR(PROVEEDOR)) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = ALLTRIM(STRTRAN(ALLTRIM(ULT_PROVEE),CHR(34),"")) && "
	lcLine = ALLTRIM(STRTRAN(lcLine,CHR(39),"")) && '
	lcLine = ALLTRIM(STRTRAN(lcLine,CHR(96),"")) && ´
	lcLine = ALLTRIM(STRTRAN(lcLine,CHR(94),"")) && ^
	lcLine = CHR(9) + CHR(34) +  "provenom" + CHR(34) + CHR(58) +  CHR(9) + CHR(34) + lcLine + CHR(34) + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) +  "send48" + CHR(34) + CHR(58) +  CHR(9) + 'false' + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) +  "send72" + CHR(34) + CHR(58) +  CHR(9) + 'false' + CHR(44) + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = CHR(9) + CHR(34) + "estado" + CHR(34) + CHR(58) +  CHR(9) + "0" + CHR(13)
	
	FWRITE(lnFileHandle, lcLine)

	lcLine = "}" + CHR(13) 
	
	FWRITE(lnFileHandle, lcLine)

ENDSCAN

FCLOSE(lnFileHandle) && don't forget to close the file

IF USED("MYREQIN")
	SELECT MYREQIN
	USE
ENDIF

IF vacio 
	DELETE FILE ("reqinter.json")
	
ELSE 
	date_now=DATETIME()
	timenow=".\JSONBACK\requinter_" + DTOS(date_now)+PADL(HOUR(date_Now),2,"0")+PADL(minute(DATETIME()),2,"0")+PADL(SEC(DATETIME()),2,"0") + ".json"

	COPY FILE ("reqinter.json") TO ("\\192.168.63.23\web\reqinter.json")
	COPY FILE ("reqinter.json") TO (timenow)

	SELECT 0
	USE MREQINTE ALIAS MREQINTE ORDER TAG PKEY
	
	SELECT REQTOWEB
	SET ORDER TO TAG PKEY
	SET FILTER TO !WEBCOMP
	GO TOP
	SCAN
		strCla = STR(REQTOWEB.EMPRESA,5)+STR(REQTOWEB.NUMERO,14)+STR(REQTOWEB.ID,6)
		
		IF REQTOWEB.ACTUALIZA
			SELECT MREQINTE
			SEEK strCla
			IF FOUND()
				REPLACE CANTIDAD WITH REQTOWEB.CANTIDAD
				REPLACE CANT_CANCE WITH REQTOWEB.CANT_CANCE
			ENDIF
		ENDIF
		
		SELECT REQTOWEB	
		REPLACE WEBCOMP WITH .T.
	ENDSCAN
ENDIF

IF USED("MREQINTE")
	SELECT MREQINTE
	USE
ENDIF

IF USED("REQTOWEB")
	SELECT REQTOWEB
	USE
ENDIF

SELECT(loArea)

RETURN && done