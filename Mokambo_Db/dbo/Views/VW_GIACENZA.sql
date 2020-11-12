


CREATE VIEW [dbo].[VW_GIACENZA]
AS
SELECT G.CODICE_NEGOZIO, A.ID_ARTICOLO, A.CODICE_ARTICOLO, A.NOME, A.NOME_BREVE, A.DESCRIZIONE, A.PREZZO_BASE, 
       G.EAN, G.GIACENZA, A.DEFAULT_IMAGE AS FOTO, A.REPARTO_VENDITA , A.LOTTO_VENDITA, C.ID_CATEGORIA, C.DESCRIZIONE_CATEGORIA,
	   R.IDREPARTO, R.DESCRIZIONEREPARTO, UM.CODICE_UM, UM.DESCRIZIONE DESCRIZIONE_UM, A.QTA_MINIMA, A.CODICE_IVA, A.STATUS,
	   A.TIPO_ARTICOLO
FROM ARTICOLO A
 INNER JOIN GIACENZA G ON A.ID_ARTICOLO = G.ID_ARTICOLO
 INNER JOIN CATEGORIA C ON C.ID_CATEGORIA = A.ID_CATEGORIA
 INNER JOIN REPARTO R ON R.IDREPARTO = A.REPARTO
 INNER JOIN UNITA_MISURA UM ON UM.CODICE_UM = A.CODICE_UM
WHERE A.STATUS = 'V'
GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_GIACENZA';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ARTICOLO"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 281
               Right = 383
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "GIACENZA"
            Begin Extent = 
               Top = 3
               Left = 554
               Bottom = 282
               Right = 776
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1644
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 2148
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'VW_GIACENZA';

