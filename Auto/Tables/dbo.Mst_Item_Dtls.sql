SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_Item_Dtls](
	[ItemId] [bigint] NOT NULL,
	[ItemCode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ItemDesc] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
