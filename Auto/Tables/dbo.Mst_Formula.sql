SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_Formula](
	[TypeID] [numeric](18, 0) NULL,
	[TaxID] [numeric](18, 0) NULL,
	[Formula] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FormulaCode] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SrNo] [numeric](18, 0) IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
