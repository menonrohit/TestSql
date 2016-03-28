/****** Cannot script Unresolved Entities : Server[@Name='DESKTOP-QHA6FLQ\SQLEXPRESSADV']/Database[@Name='Auto']/UnresolvedEntity[@Name='Mst_Accounts'] ******/
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_VoucherPrefix](
	[EntryName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Prefix] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Startno] [numeric](18, 0) NULL,
	[Minlength] [int] NOT NULL CONSTRAINT [DF_Mst_VoucherPrefix_Minlength]  DEFAULT (3),
	[CurrentNo] [numeric](18, 0) NOT NULL CONSTRAINT [DF_Mst_VoucherPrefix_CurrentNo]  DEFAULT (0)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_ReportLink](
	[AcId] [bigint] NULL,
	[Report_Name] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ColPos] [float] NULL,
	[Code] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO
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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_Journal](
	[JournalID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[JournalNo] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[JournalDate] [datetime] NULL,
	[AcID] [numeric](18, 0) NOT NULL,
	[GrandTotal] [money] NOT NULL,
	[CrDr] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Narration] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TypeOfEntry] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ER1PeriodFrom] [datetime] NULL,
	[ER1PeriodTo] [datetime] NULL
)

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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[trn_Daybook](
	[DBookID] [numeric](18, 0) NOT NULL,
	[Vno] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Vtype] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Debtor] [numeric](18, 0) NULL,
	[Creditor] [numeric](18, 0) NULL,
	[Amount] [money] NULL,
	[VDate] [datetime] NULL,
	[Cash] [money] NULL,
	[OnAccount] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Srno] [int] NULL,
	[DescAcID] [numeric](18, 0) NULL,
	[Per_Age] [bigint] NULL DEFAULT ((0)),
	[Temp_ActualAmt] [money] NULL DEFAULT ((0))
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc SP_AutoExiciseJV @ToDate DateTime 
GO