﻿
CREATE PROCEDURE [dbo].[PRC_INSERT_COMANDA_RIGA]
@ID_COMANDA			  INT,
@ID_BASKET			  INT,
@ID_REPARTO			  INT,
@RISULTATO			  CHAR(2) = '' OUTPUT,
@DESRISULTATO		  VARCHAR(1000)	= '' OUTPUT
AS
SET NOCOUNT ON
BEGIN TRY 

 /*
	MERGE INTO [dbo].[COMANDA_RIGA] AS TARGET

	USING (select @ID_COMANDA, BR.RIGA, BR.BOX, BR.ID_MENU, BR.ID_ARTICOLO, BR.PREZZO, BR.QTA, BR.ISTRUZIONI, 
			case when  isnull(cr.QTA_EVASA, 0) > 0 then cr.qta_evasa else 0 end as qta_evasa
			from BASKET_RIGA BR
			JOIN ARTICOLO A ON A.ID_ARTICOLO = BR.ID_ARTICOLO
			left join [dbo].[COMANDA_RIGA] cr on cr.ID_COMANDA = @ID_COMANDA	
			where ID_BASKET = @ID_BASKET AND ID_REPARTO = @ID_REPARTO)

    AS SOURCE(ID_COMANDA, RIGA, BOX, ID_MENU, ID_ARTICOLO, PREZZO, QTA, ISTRUZIONI, QTA_EVASA)

	ON SOURCE.ID_COMANDA = TARGET.ID_COMANDA AND SOURCE.RIGA = TARGET.RIGA
	WHEN MATCHED THEN UPDATE SET BOX = SOURCE.BOX,
								 ID_MENU = SOURCE.ID_MENU,
								 ID_ARTICOLO = SOURCE.ID_ARTICOLO,
								 PREZZO = SOURCE.PREZZO,
								 QTA = SOURCE.QTA,
								 ISTRUZIONI = SOURCE.ISTRUZIONI,
								 QTA_EVASA = SOURCE.QTA_EVASA
	WHEN NOT MATCHED THEN INSERT (ID_COMANDA, RIGA, BOX, ID_MENU, ID_ARTICOLO, PREZZO, QTA, ISTRUZIONI, QTA_EVASA)
						  VALUES (SOURCE.ID_COMANDA, SOURCE.RIGA, SOURCE.BOX, SOURCE.ID_MENU, SOURCE.ID_ARTICOLO, SOURCE.PREZZO, SOURCE.QTA, SOURCE.ISTRUZIONI, SOURCE.QTA_EVASA);
*/
	INSERT INTO COMANDA_RIGA(ID_COMANDA, ID_MENU, ID_ARTICOLO, BOX, PREZZO, QTA, ISTRUZIONI, QTA_EVASA)
	select @ID_COMANDA, BR.ID_MENU, BR.ID_ARTICOLO, BR.BOX, BR.PREZZO, BR.QTA - BR.QTA_INVIATA, BR.ISTRUZIONI, 0
	from BASKET_RIGA BR
	JOIN ARTICOLO A ON A.ID_ARTICOLO = BR.ID_ARTICOLO
	left join [dbo].[COMANDA_RIGA] cr on cr.ID_COMANDA = @ID_COMANDA	
	where ID_BASKET = @ID_BASKET AND ID_REPARTO = @ID_REPARTO AND BR.QTA <> BR.QTA_INVIATA
/*
	DECLARE
	@qta				  INT=0,
	@qta_Evasa			  INT=0

	select @qta = qta, @qta_Evasa=qta_evasa from [dbo].[COMANDA_RIGA] 
		where ID_COMANDA = @ID_COMANDA

	if (@qta_evasa = 0) 
		update [dbo].[COMANDA_TESTATA] set [EVASA] = 0
	else
	if (@qta_evasa <> @qta) 
		update [dbo].[COMANDA_TESTATA] set [EVASA] = 0
	else
		update [dbo].[COMANDA_TESTATA] set [EVASA] = 1
*/
	SET @RISULTATO = 'OK'
	SET @DESRISULTATO = 'INSERIMENTO EFFETTUATO CORRETTAMENTE'
		
END TRY
BEGIN CATCH
	SET @RISULTATO = 'KO'
	SET @DESRISULTATO = ERROR_MESSAGE()
END CATCH