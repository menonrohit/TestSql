SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function SF_CreditUtilized(@Fromdt DateTime,@ToDate DateTime)  
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
CREATE TABLE [dbo].[Trn_Bills_Rcvble](
	[AcID] [numeric](18, 0) NOT NULL,
	[EntryID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[InvNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[InvDate] [datetime] NOT NULL,
	[InvAmount] [money] NOT NULL,
	[InvFrom] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[InvID] [numeric](18, 0) NOT NULL,
	[DueDays] [int] NULL,
	[Labour] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
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
CREATE TABLE [dbo].[Mst_Party](
	[AcID] [numeric](18, 0) NULL,
	[AcName] [varchar](120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[PtyName] [varchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyUnit] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyAddress1] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyAddress2] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyAddress3] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyCityID] [int] NULL,
	[PtyStateID] [int] NULL,
	[PtyPin] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyOffPhone] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyFax] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyEmail] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyWeb] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyPlantPhone] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyVAT] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyCST] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyExcise] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyPANno] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ptyPLAno] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyType] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyServiceTax] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyRange] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyDivision] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyCommisionarate] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyCertification] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyNotes] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyOpeningBalance] [money] NULL,
	[DrCr] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyManuType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VendorCode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Used] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Category] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ContPerson] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExpLic0] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExpLic1] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShortName] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Priority] [int] NULL,
	[TDS] [int] NULL,
	[ScopeSupply] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SelCriteria] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExtControl] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PartyType] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ContryName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[trn_TaxInvoice](
	[InvID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[InvDate] [datetime] NULL,
	[InvNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyID] [numeric](18, 0) NULL,
	[CoID] [numeric](18, 0) NULL,
	[PoNo] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PoDate] [datetime] NULL,
	[AmdNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AmdDate] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Amount] [money] NULL,
	[Discount] [money] NULL,
	[Packing] [money] NULL,
	[Packingpercent] [real] NULL,
	[Total] [money] NULL,
	[Roundoff] [real] NULL,
	[NetAmount] [money] NULL,
	[Transport] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Vehicleno] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CashCredit] [varchar](9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DayBookID] [numeric](18, 0) NULL,
	[PrepareTime] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IssueTime] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExciseChapter] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LRNo] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LRDate] [varchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TariffCode] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DcNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DcDate] [varchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DueDays] [numeric](18, 0) NULL,
	[ROffFlag] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AcHeadID] [numeric](18, 0) NULL,
	[PrepareDate] [datetime] NULL,
	[RemovalDate] [datetime] NULL,
	[ModofTranspts] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Pay_Terms] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Consignee] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Consignee_Cod] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Add1] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Add2] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Add3] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Commodity] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Doc_Thru] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RatOfDuty] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NoOfPacking] [bigint] NULL,
	[Pay_DueDt] [datetime] NULL,
	[Remarks] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Remarks1] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Remarks2] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GeneratedBy] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ApprovedBy] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TypeOfGoods] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PurchReturn] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExportInvNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PackingDimension] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DispatchThru] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PackedBy] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Contents] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MaterialUsed] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NetWeight] [float] NULL,
	[GrossWeight] [float] NULL,
	[PackingDesc] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MarkedPacked] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CountryDesign] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PortLoading] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PortDischarge] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FOB] [smallint] NULL,
	[CNF] [smallint] NULL,
	[EXW] [smallint] NULL,
	[Exwork] [smallint] NULL,
	[ExpInvId] [bigint] NULL,
	[SpelInstruction] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ARE14] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ARE15] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ARE1] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ARE2] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PrintTransport] [tinyint] NULL
)

GO