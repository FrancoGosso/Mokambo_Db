﻿

CREATE PROCEDURE [dbo].[PRC_GET_ALLERGENI]
@ID_ALLERGENE INT = 0
AS
BEGIN
	SET NOCOUNT ON
	SELECT * FROM ALLERGENE
	WHERE ID_ALLERGENE = CASE WHEN @ID_ALLERGENE = 0 THEN ID_ALLERGENE ELSE @ID_ALLERGENE END
	ORDER BY DESCRIZIONE
END