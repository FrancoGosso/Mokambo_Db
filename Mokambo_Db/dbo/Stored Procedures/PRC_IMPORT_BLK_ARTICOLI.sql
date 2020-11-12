CREATE  PROCEDURE [dbo].[PRC_IMPORT_BLK_ARTICOLI]
@SEPARATORE   varchar(1) ,
@NOMEFILE   varchar(100) ,
@NEGOZIO   varchar(20) ,
@DESRISULTATO	VARCHAR(1000)= '' OUTPUT,
@RISULTATO  VARCHAR(2) = '' OUTPUT,
@STRSQL     VARCHAR(8000)  = 'PP' OUTPUT

AS
BEGIN
   SET NOCOUNT ON;
   SET	@RISULTATO = 'IN'
   SET @DESRISULTATO = 'FATTO NIENTE'
   	
 --  DECLARE     @SEPARATORE  CHAR(1)
 --  SET         @SEPARATORE = ','
    
BEGIN TRY
	
	BEGIN TRANSACTION 
	-- acquisisco il progressivo, ovvero l'autoincrement per ID_ARTICOLO
	DECLARE @PROG int

	exec dbo.prc_get_progressivo 'ARTICOLO','ALL',@PROG output
	print @PROG

	-- creo due tabelle virtuali, la prima per immagazzinare i dati del file csv, la seconda per creare il id_articolo progressivo

	--da decommentare in fase di test
	/*DROP TABLE  #APPO_BULK_ARTICOLO
	DROP TABLE  #ART_TO_UPDATE
	DROP TABLE  #ART_TO_INSERT
	DROP TABLE  #SCARTI*/
	
	CREATE TABLE  #APPO_BULK_ARTICOLO
	(
	[CODICE_ARTICOLO] [varchar](20) not null,
	[NOME] [varchar](250) not null,
	[NOME_BREVE] [varchar](25) not null,
	[DESCRIZIONE] [varchar] (5000) default '', 
	[ID_CATEGORIA] [varchar] (2) not null,
	[DEFAULT_IMAGE] [varchar](250) default '',
	[CODICE_IVA] [varchar](10) default '',
	[PREZZO_BASE] [varchar] (8) not null,
	[CODICE_UM] [varchar](3) not null,
	[REPARTO_VENDITA] [char] not null,
	[LOTTO_VENDITA] [char] not null,
	[TIPO_ARTICOLO] [char] not null,
	[CODICE_ARTICOLO_PRINCIPALE] [varchar] (20) default '',
	[CODICE_UM_ARTICOLO_PRINCIPALE] [varchar] (3) default 'UN',
	[QTA_ARTICOLO_PRINCIPALE] [varchar] (11) default '00000000000',
	[AZIONE] [char] not null)
	
	CREATE TABLE  #SCARTI
	(
	[CODICE_ARTICOLO] [varchar](20) not null,
	[NOME] [varchar](250) not null,
	[NOME_BREVE] [varchar](25) not null,
	[DESCRIZIONE] [varchar] (5000) default '', 
	[ID_CATEGORIA] [varchar] (2) not null,
	[DEFAULT_IMAGE] [varchar](250) default '',
	[CODICE_IVA] [varchar](10) default '',
	[PREZZO_BASE] [varchar] (8) not null,
	[CODICE_UM] [varchar](3) not null,
	[REPARTO_VENDITA] [char] not null,
	[LOTTO_VENDITA] [char] not null,
	[TIPO_ARTICOLO] [char] not null,
	[CODICE_ARTICOLO_PRINCIPALE] [varchar] (20) default '',
	[CODICE_UM_ARTICOLO_PRINCIPALE] [varchar] (3) default 'UN',
	[QTA_ARTICOLO_PRINCIPALE] [varchar] (11) default '0',
	[AZIONE] [char] not null)
	
	CREATE TABLE  #ART_TO_UPDATE
	(
	[CODICE_ARTICOLO] [varchar](20) not null,
	[NOME] [varchar](250) not null,
	[NOME_BREVE] [varchar](25) not null,
	[DESCRIZIONE] [varchar] (5000) default '', 
	[ID_CATEGORIA] [int] not null,
	[DEFAULT_IMAGE] [varchar](250) default '',
	[CODICE_IVA] [varchar](10) default '',
	[PREZZO_BASE] [money] not null,
	[CODICE_UM] [varchar](3) not null,
	[REPARTO_VENDITA] [char] not null,
	[LOTTO_VENDITA] [char] not null,
	[TIPO_ARTICOLO] [char] not null,
	[CODICE_ARTICOLO_PRINCIPALE] [varchar] (20) default '',
	[CODICE_UM_ARTICOLO_PRINCIPALE] [varchar] (3) default 'UN',
	[QTA_ARTICOLO_PRINCIPALE] [decimal](11,3) default 0,
	[AZIONE] [char] not null)
	
	CREATE TABLE  #ART_TO_INSERT
	(
	[CODICE_ARTICOLO] [varchar](20) not null,
	[NOME] [varchar](250) not null,
	[NOME_BREVE] [varchar](25) not null,
	[DESCRIZIONE] [varchar] (5000) default '', 
	[ID_CATEGORIA] [int] not null,
	[DEFAULT_IMAGE] [varchar](250) default '',
	[CODICE_IVA] [varchar](10) default '',
	[PREZZO_BASE] [money] not null,
	[CODICE_UM] [varchar](3) not null,
	[REPARTO_VENDITA] [char] not null,
	[LOTTO_VENDITA] [char] not null,
	[TIPO_ARTICOLO] [char] not null,
	[CODICE_ARTICOLO_PRINCIPALE] [varchar] (20) default '',
	[CODICE_UM_ARTICOLO_PRINCIPALE] [varchar] (3) default 'UN',
	[QTA_ARTICOLO_PRINCIPALE] [decimal](11,3) default 0,
	[AZIONE] [char] not null)
	
	-- genero id articolo progressivo
					
 	DECLARE @Statement VARCHAR(MAX)

	SET @Statement = 'ALTER TABLE #ART_TO_INSERT 
	ADD ID_ARTICOLO INT IDENTITY(' + CAST((@PROG) AS VARCHAR) + ', 1);'

	EXEC (@Statement)
	
	-- leggo i dati dal file csv	
	
    SELECT @STRSQL =               ' BULK INSERT  #APPO_BULK_ARTICOLO  FROM  ' + CHAR(39) +  @NOMEFILE + CHAR(39)   
    SELECT @STRSQL = @STRSQL   +   ' WITH ( '
    SELECT @STRSQL = @STRSQL   +   ' FIELDTERMINATOR  = ''' +  @SEPARATORE    + CHAR(39) + ' ,  ROWTERMINATOR =  ''' +  CHAR(10) +   ''')'   
    
    PRINT @STRSQL
 
 	SELECT  @STRSQL = @STRSQL 
 	EXECUTE(@STRSQL)
 
	--controlli 
 	
 	--codice categoria
 	insert into #SCARTI select * from #APPO_BULK_ARTICOLO where ID_CATEGORIA <> 10 and ID_CATEGORIA <> 20 and ID_CATEGORIA <> 70 and ID_CATEGORIA <> 80
 	--unità di misura 
 	insert into #SCARTI select blk.* from #APPO_BULK_ARTICOLO blk left join UNITA_MISURA um on um.CODICE_UM = blk.CODICE_UM  where um.CODICE_UM is null
 	--reparto di vendita 
 	insert into #SCARTI select * from #APPO_BULK_ARTICOLO where REPARTO_VENDITA <> 1 and REPARTO_VENDITA <> 2 and REPARTO_VENDITA <> 3
 	--lotto di vendita 
 	insert into #SCARTI select * from #APPO_BULK_ARTICOLO where LOTTO_VENDITA <> 1 and LOTTO_VENDITA <> 2
 	--tipo articolo 
 	insert into #SCARTI select * from #APPO_BULK_ARTICOLO where TIPO_ARTICOLO <> 'C' and TIPO_ARTICOLO <> 'S'
 	--unità di misura ingrediente principale
 	insert into #SCARTI select blk.* from #APPO_BULK_ARTICOLO blk left join UNITA_MISURA um on um.CODICE_UM = blk.CODICE_UM_ARTICOLO_PRINCIPALE  where um.CODICE_UM is null and blk.CODICE_UM_ARTICOLO_PRINCIPALE <> null
 	--azione 
 	insert into #SCARTI select * from #APPO_BULK_ARTICOLO where AZIONE <> 'I' and AZIONE <> 'A'
 
	--cancello tuple che fanno parte della tabella scarti
	delete #APPO_BULK_ARTICOLO 
	from #APPO_BULK_ARTICOLO blk inner join #SCARTI s on blk.CODICE_ARTICOLO = s.CODICE_ARTICOLO
	
	--copio la tabella con i dati del file in quella con l'id_articolo eliminado il carattere ' '
	insert #ART_TO_INSERT  select	  RTRIM(BLK.CODICE_ARTICOLO),
										  RTRIM(BLK.NOME),
										  RTRIM(BLK.NOME_BREVE),
										  RTRIM(BLK.DESCRIZIONE) ,
										  RTRIM(BLK.ID_CATEGORIA),
										  RTRIM(BLK.DEFAULT_IMAGE),
										  RTRIM(BLK.CODICE_IVA),
										  RTRIM(BLK.PREZZO_BASE),										  
										  RTRIM(BLK.CODICE_UM),
										  RTRIM(BLK.REPARTO_VENDITA),							
										  RTRIM(BLK.LOTTO_VENDITA),										    
										  RTRIM(BLK.TIPO_ARTICOLO), 
										  RTRIM(BLK.CODICE_ARTICOLO_PRINCIPALE), 
										  RTRIM(BLK.CODICE_UM_ARTICOLO_PRINCIPALE),
										  RTRIM(BLK.QTA_ARTICOLO_PRINCIPALE),
										  RTRIM(BLK.AZIONE) 
								from #APPO_BULK_ARTICOLO BLK left join ARTICOLO A on BLK.CODICE_ARTICOLO = A.CODICE_ARTICOLO
								where A.CODICE_ARTICOLO IS NULL
 	
 	insert #ART_TO_UPDATE  select		  RTRIM(BLK.CODICE_ARTICOLO),
										  RTRIM(BLK.NOME),
										  RTRIM(BLK.NOME_BREVE),
										  RTRIM(BLK.DESCRIZIONE) ,
										  RTRIM(BLK.ID_CATEGORIA),
										  RTRIM(BLK.DEFAULT_IMAGE),
										  RTRIM(BLK.CODICE_IVA),
										  RTRIM(BLK.PREZZO_BASE),										  
										  RTRIM(BLK.CODICE_UM),
										  RTRIM(BLK.REPARTO_VENDITA),							
										  RTRIM(BLK.LOTTO_VENDITA),										    
										  RTRIM(BLK.TIPO_ARTICOLO), 
										  RTRIM(BLK.CODICE_ARTICOLO_PRINCIPALE), 
										  RTRIM(BLK.CODICE_UM_ARTICOLO_PRINCIPALE),
										  RTRIM(BLK.QTA_ARTICOLO_PRINCIPALE),
										  RTRIM(BLK.AZIONE) 
								from #APPO_BULK_ARTICOLO BLK join ARTICOLO A on BLK.CODICE_ARTICOLO = A.CODICE_ARTICOLO
								
	-- costruisco il Prezzo con i decimali
	UPDATE #ART_TO_UPDATE SET PREZZO_BASE = PREZZO_BASE/100
	UPDATE #ART_TO_INSERT SET PREZZO_BASE = PREZZO_BASE/100
 	
 	--qta articolo principale da convertire con gli ultimi 3 campi decimali
 	UPDATE #ART_TO_UPDATE SET QTA_ARTICOLO_PRINCIPALE = QTA_ARTICOLO_PRINCIPALE/1000 
 	UPDATE #ART_TO_INSERT SET QTA_ARTICOLO_PRINCIPALE = QTA_ARTICOLO_PRINCIPALE/1000 
 	
 	
	-- CANCELLAZIONE ARTICOLI 
	
	DELETE ARTICOLO
	FROM #APPO_BULK_ARTICOLO BLK
     		              LEFT JOIN ARTICOLO art
                          ON BLK.CODICE_ARTICOLO  =	art.CODICE_ARTICOLO
    WHERE BLK.AZIONE = 'A'
                                               
  	-- AGGIORNAMENTO PREESISTENTI   
    
	UPDATE  ARTICOLO   
	SET     CODICE_ARTICOLO=BLKART.CODICE_ARTICOLO,
		    NOME =  BLKART.NOME,
		    NOME_BREVE = BLKART.NOME_BREVE,
		    DESCRIZIONE = CASE WHEN cast(ISNULL(BLKART.DESCRIZIONE,'') as varchar)= '' THEN BLKART.NOME ELSE BLKART.DESCRIZIONE END,
		    ID_CATEGORIA = BLKART.ID_CATEGORIA, 
		    CODICE_IVA = BLKART.CODICE_IVA,
		    PREZZO_BASE = BLKART.PREZZO_BASE,
		    CODICE_UM = BLKART.CODICE_UM,
		    REPARTO_VENDITA= BLKART.REPARTO_VENDITA,
		    REPARTO= BLKART.REPARTO_VENDITA,
		    LOTTO_VENDITA = BLKART.LOTTO_VENDITA,
		    TIPO_ARTICOLO = BLKART.TIPO_ARTICOLO,
			CODICE_ARTICOLO_PRINCIPALE = BLKART.CODICE_ARTICOLO_PRINCIPALE,
			CODICE_UM_ARTICOLO_PRINCIPALE = BLKART.CODICE_UM_ARTICOLO_PRINCIPALE,
			QTA_ARTICOLO_PRINCIPALE = BLKART.QTA_ARTICOLO_PRINCIPALE
	FROM	#ART_TO_UPDATE  BLKART  INNER JOIN  ARTICOLO  ART ON
                                             BLKART.CODICE_ARTICOLO = ART.CODICE_ARTICOLO                                       
                                             
   --INSERIMENTO ARTICOLI NUOVI

	SET         @RISULTATO      = 'OK'
	SET         @DESRISULTATO	= 'TUTTO OK'	
	INSERT  INTO    ARTICOLO (ID_ARTICOLO,
							  CODICE_ARTICOLO,
	                          NOME,
	                          NOME_BREVE,
	                          DESCRIZIONE ,
	                          ID_CATEGORIA ,
							  DEFAULT_IMAGE,
							  CODICE_IVA,
	                          PREZZO_BASE,
	                          CODICE_UM,
	                          REPARTO_VENDITA,
	                          REPARTO,
	                          LOTTO_VENDITA,
							  TIPO_ARTICOLO,
							  STATUS,
							  CODICE_ARTICOLO_PRINCIPALE,
							  CODICE_UM_ARTICOLO_PRINCIPALE,
							  QTA_ARTICOLO_PRINCIPALE) 
			SELECT            BLK.ID_ARTICOLO,
							  BLK.CODICE_ARTICOLO,
	                          BLK.NOME,
	                          BLK.NOME_BREVE,
	                          CASE WHEN cast(ISNULL(BLK.DESCRIZIONE,'') as varchar)= '' THEN BLK.NOME ELSE BLK.DESCRIZIONE END,
	                          BLK.ID_CATEGORIA ,
							  BLK.DEFAULT_IMAGE,
							  BLK.CODICE_IVA,
	                          BLK.PREZZO_BASE, 
	                          BLK.CODICE_UM,
	                          BLK.REPARTO_VENDITA,
	                          BLK.REPARTO_VENDITA,
	                          BLK.LOTTO_VENDITA,  
	                          BLK.TIPO_ARTICOLO,
	                          'N',
	                          BLK.CODICE_ARTICOLO_PRINCIPALE, 
	                          BLK.CODICE_UM_ARTICOLO_PRINCIPALE,
	                          BLK.QTA_ARTICOLO_PRINCIPALE   
	        FROM #ART_TO_INSERT BLK
     		              LEFT JOIN ARTICOLO art
                          ON BLK.CODICE_ARTICOLO  =  art.CODICE_ARTICOLO
            WHERE art.ID_ARTICOLO IS NULL AND BLK.AZIONE = 'I' 
            
    --Inserimento dati in giacenza        
    INSERT INTO GIACENZA(CODICE_NEGOZIO,
						 EAN,
						 ID_ARTICOLO, 
						 GIACENZA,
						 RIORDINO)
			SELECT		@NEGOZIO,
						BLK.ID_ARTICOLO,
						BLK.ID_ARTICOLO,
						999,
						999
			FROM #ART_TO_INSERT BLK
     
     --aggiornamento tabella progressivo
     update PROGRESSIVO set PROGR = ISNULL((select MAX(ID_ARTICOLO) from #ART_TO_INSERT),PROGR) where CODICE = 'ARTICOLO'and CODICE_NEGOZIO = 'ALL'
     
     --esportare la tabella scarti su file csv con filename = scarti_@NOMEFILE_timestamp.csv, alinterno di una cartella Flussi\Import\Scarti\
     select * from #SCARTI

	 SET    @RISULTATO    = 'OK'
	 SET    @DESRISULTATO = 'TUTTO OK'

            
	 
END TRY
	
BEGIN CATCH
    SET @RISULTATO = 'KO'
	SET @DESRISULTATO = ERROR_MESSAGE()
END CATCH


IF @RISULTATO = 'OK' 
	COMMIT TRANSACTION
ELSE
	ROLLBACK TRANSACTION
END