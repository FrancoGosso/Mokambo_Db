﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PRC_GET_CANALEVENDITA]
 @COD_CANALE_VENDITA	VARCHAR(10) = '0',
 @DES_CANALE_VENDITA	VARCHAR(500) = ' ' 
AS  
BEGIN
	SET NOCOUNT ON
	
	SELECT	COD_CANALE_VENDITA, DES_CANALE_VENDITA
	INTO	#RISULTATO
	FROM	CANALE_VENDITA
	WHERE
	COD_CANALE_VENDITA =	CASE WHEN  @COD_CANALE_VENDITA = '0' THEN COD_CANALE_VENDITA ELSE @COD_CANALE_VENDITA END 
 
	SELECT * FROM #RISULTATO	ORDER BY DES_CANALE_VENDITA
	

END