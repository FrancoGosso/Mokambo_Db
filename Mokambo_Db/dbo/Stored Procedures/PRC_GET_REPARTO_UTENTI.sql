﻿

create PROCEDURE [dbo].[PRC_GET_REPARTO_UTENTI]
@IDREPARTO INT = 0
AS
BEGIN
	SET NOCOUNT ON
	
    SELECT * FROM REPARTO_UTENTI
	WHERE STATUS = 'V'
	AND	IDREPARTO = CASE WHEN @IDREPARTO = 0 THEN IDREPARTO ELSE @IDREPARTO END  
	
END