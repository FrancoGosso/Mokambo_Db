﻿CREATE PROCEDURE [dbo].[PRC_GET_COMANDA_RIGA]
@ID_COMANDA INT
AS
	SET NOCOUNT ON
	SELECT CR.*, A.NOME FROM COMANDA_RIGA CR
	JOIN ARTICOLO A ON A.ID_ARTICOLO = CR.ID_ARTICOLO
	WHERE ID_COMANDA = @ID_COMANDA
	ORDER BY BOX