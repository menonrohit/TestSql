SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_ListCustomerDrawingDtls](
	[DRGID] [bigint] NOT NULL,
	[SrNo] [bigint] NOT NULL,
	[Drg_Owner] [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PartName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Part_DrgNo] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RevDate] [datetime] NOT NULL,
	[RevNo] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]

GO
