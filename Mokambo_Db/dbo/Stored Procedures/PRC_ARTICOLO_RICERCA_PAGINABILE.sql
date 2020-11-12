﻿

-- =============================================
-- AUTHOR:		DS
-- CREATE DATE: 26-06-2019
-- DESCRIPTION:	RICERCA  PAGINABILE ARTICOLO
-- =============================================
CREATE PROCEDURE [dbo].[PRC_ARTICOLO_RICERCA_PAGINABILE]
@CODARTICOLO			VARCHAR(20) = '',
@IDARTICOLO				INT=0,
@NOMEARTICOLO			VARCHAR(250) = '' ,
@IDCATEGORIA			INT=0,
@PAGESIZE				INT=50,
@PAGINADESIDERATA		INT=1,
@SORTBY					INT=1,
@RISULTATO				VARCHAR(2) = '' OUTPUT,
@DESRISULTATO			VARCHAR(250) = '' OUTPUT,
@NUMRECTOT				INT  = 0 OUTPUT ,
@NUMRECFILTRATI			INT  = 0 OUTPUT ,
@NUMPAGTOT				INT  = 0 OUTPUT     
AS
BEGIN
 
	SET @NUMRECTOT = 0
	SET @NUMRECFILTRATI = 0	
	SET @NUMPAGTOT = 0
	
 

	SET @RISULTATO = 'OK'
	SET @DESRISULTATO = ''		
	
	SELECT @NUMRECTOT = 0
	SELECT @NUMRECFILTRATI = 0	
	SELECT @NUMPAGTOT = 0
	SET NOCOUNT ON;
 
	SELECT @NUMRECTOT= COUNT(*) FROM ARTICOLO --WHERE IDSHOP = @IDSHOP 
	
	CREATE TABLE #ARTICOLO
		(
			RIGA		INT IDENTITY,
			PAGINA		INT DEFAULT  0,
			IDARTICOLO	INT)
 
	INSERT INTO #ARTICOLO(IDARTICOLO)
	SELECT ID_ARTICOLO
	FROM 
		ARTICOLO C WITH (NOLOCK) 
	WHERE 
		--C.IDSHOP = @IDSHOP
		 ID_ARTICOLO = CASE @IDARTICOLO WHEN 0 THEN ID_ARTICOLO ELSE @IDARTICOLO END
		AND NOME LIKE '' + CASE WHEN @NOMEARTICOLO <> '' THEN '%' + @NOMEARTICOLO ELSE NOME END + '%'	
		AND CODICE_ARTICOLO = CASE @CODARTICOLO WHEN '' THEN CODICE_ARTICOLO ELSE @CODARTICOLO END 
		AND ID_CATEGORIA = CASE @IDCATEGORIA WHEN 0 THEN ID_CATEGORIA ELSE @IDCATEGORIA END
 
 
	ORDER BY	
			CASE WHEN @SORTBY = 1 THEN NOME END,
			CASE WHEN @SORTBY = -1 THEN NOME END DESC,
			CASE WHEN @SORTBY = 2 THEN CODICE_ARTICOLO END,
			CASE WHEN @SORTBY = -2 THEN CODICE_ARTICOLO END DESC

 		

	UPDATE #ARTICOLO SET PAGINA = CEILING(CAST(RIGA AS FLOAT) / CAST(@PAGESIZE AS FLOAT))
	
	SELECT @NUMRECFILTRATI = COUNT(*) FROM #ARTICOLO
	SELECT @NUMPAGTOT = ISNULL(MAX(PAGINA),0) FROM #ARTICOLO 
	
	 
	SELECT b.*, ISNULL(C.DESCRIZIONE_CATEGORIA ,'') AS DESCRIZIONE_CATEGORIA,  ISNULL(R.DESCRIZIONEREPARTO ,'') AS DESCRIZIONE_REPARTO,  ISNULL(U.DESCRIZIONE ,'') AS DESCRIZIONE_UM
	FROM #ARTICOLO A JOIN ARTICOLO B ON A.IDARTICOLO= B.ID_ARTICOLO LEFT JOIN
	CATEGORIA C ON B.ID_CATEGORIA = C.ID_CATEGORIA
	LEFT JOIN REPARTO R ON B.REPARTO = R.IDREPARTO 
	LEFT JOIN UNITA_MISURA U ON B.CODICE_UM = U.CODICE_UM
	WHERE PAGINA = @PAGINADESIDERATA ORDER BY RIGA

 	FINE:
	PRINT @RISULTATO  
	PRINT @DESRISULTATO 	
	PRINT @NUMRECTOT
	PRINT @NUMRECFILTRATI	
	PRINT @NUMPAGTOT
END