SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_LedgerLinkRpt](
	[AcId] [bigint] NOT NULL,
	[Report_Name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ColPos] [int] NULL,
	[MinAmt] [money] NULL,
	[Code] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
