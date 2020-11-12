-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PRC_GET_USER_NEGOZIObyUSERID]
@USERID 	   INT				= 0 ,
@NOME    	   VARCHAR(64)		= '',
@COGNOME       VARCHAR(64)	    = '', 
@EAN 		   NVARCHAR(13)		= '',  
@PUOSCONTARE   NCHAR(2)         = ''
AS
BEGIN
    SET NOCOUNT ON;
	SELECT  UserId  , Cognome , Nome , Ean ,puoScontare 
       FROM USER_NEGOZIO 
	WHERE
		USER_NEGOZIO.UserId = CASE WHEN  @USERID = 0 THEN USER_NEGOZIO.UserId  ELSE @USERID END  
END