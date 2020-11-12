﻿
CREATE PROCEDURE [dbo].[PRC_GET_BASKET_ORDINAZIONI]
@UTENTE varchar(30)
AS
SET NOCOUNT ON

select * from [dbo].[BASKET_TESTATA] t
   join [dbo].[BASKET_RIGA] r on t.ID_BASKET = r.ID_BASKET
  where [CODICE_UTENTE] = @UTENTE
   and  EVASO = 0