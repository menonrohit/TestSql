SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_Item](
	[IGrID] [int] NULL,
	[ItemID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[IName] [varchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IDrNum] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IcatID] [numeric](18, 0) NULL,
	[IHmeasure] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IHunit] [float] NULL,
	[ILmeasure] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IMinlevel] [float] NULL,
	[IMaxlevel] [float] NULL,
	[IRol] [float] NULL,
	[IPrate] [money] NULL,
	[ISrate] [money] NULL,
	[IOqty] [float] NULL,
	[IExcommdity] [varchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TariffID] [numeric](18, 0) NULL,
	[ISubcatID] [numeric](18, 0) NULL,
	[IGrade] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Used] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ItemCost] [money] NOT NULL CONSTRAINT [DF_Mst_Item_ItemCost]  DEFAULT (0),
	[ILocation] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProdCode] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StkRate] [money] NULL,
	[CastWeight] [float] NULL,
	[FinishWeight] [float] NULL,
	[ReUse] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
