﻿

CREATE PROCEDURE [dbo].[PRC_GET_INGREDIENTI]
@ID_INGREDIENTE INT = 0
AS
BEGIN
	SET NOCOUNT ON
	SELECT * FROM INGREDIENTE
	WHERE ID_INGREDIENTE = CASE WHEN @ID_INGREDIENTE = 0 THEN ID_INGREDIENTE ELSE @ID_INGREDIENTE END
	ORDER BY DESCRIZIONE
END