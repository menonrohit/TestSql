SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_ItemSubCat](
	[ISubCatID] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[ISubCatName] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
