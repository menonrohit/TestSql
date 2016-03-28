/****** Cannot script Unresolved Entities : Server[@Name='DESKTOP-QHA6FLQ\SQLEXPRESSADV']/Database[@Name='Auto']/UnresolvedEntity[@Name='Mst_Accounts'] ******/
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_DayBook_Debit](
	[DBookID] [numeric](18, 0) NOT NULL,
	[AcID] [numeric](18, 0) NOT NULL,
	[VDate] [datetime] NOT NULL,
	[Description] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VType] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VNo] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Amount] [money] NOT NULL,
	[Narration] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BankDate] [datetime] NULL,
	[PurchaseRef] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL DEFAULT (''),
	[Per_Age] [bigint] NULL DEFAULT ((0))
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_DayBook_Credit](
	[DBookID] [numeric](18, 0) NOT NULL,
	[AcID] [numeric](18, 0) NOT NULL,
	[VDate] [datetime] NOT NULL,
	[Description] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VType] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VNo] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Amount] [money] NOT NULL,
	[Narration] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BankDate] [datetime] NULL,
	[PurchaseRef] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL DEFAULT (''),
	[Per_Age] [bigint] NULL DEFAULT ((0))
)

GO