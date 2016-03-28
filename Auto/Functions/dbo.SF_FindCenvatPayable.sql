SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 Create Function SF_FindCenvatPayable(@FromDt DateTime,@ToDate DateTime)  Returns @Tmp_Result Table (TariffId BigInt,TariffCode Varchar(100), Description Varchar(100),QtyCleared Float,QtyWeight Float,AssAmount Float)  As Begin Insert Into @Tmp_Result (TariffId,TariffCode,Description,QtyCleared,QtyWeight,AssAmount)  Select A.TariffID,A.TariffCode,A.Description,Sum(A.QtyCleared) As QtyCleared,  Sum(A.QtyWeight) As QtyWeight,FF.AssesableAmt From (Select F.TariffID, F.TariffCode,F.Description,Sum(TD.Qty) As QtyCleared ,  Sum(TD.Qty) * IsNull(I.CastWeight,0) As QtyWeight From trn_TaxInvoiceDetails TD  Inner Join Trn_TaxInvoice T On T.InvID = Td.InvID Inner Join Mst_Item I ON I.ItemID = Td.ItemID  Inner Join Mst_Tariff F On F.TariffID = I.TariffID Where T.InvDate Between @FromDt and @ToDate And T.PurchReturn = 'No'  Group By I.CastWeight,I.ItemID,F.TariffCode,F.Description,F.TariffID) A  Inner Join (Select F.TariffID, Sum(T.Amount) As AssesableAmt From trn_TaxInvoice T   Inner Join trn_TaxInvoiceDetails TD On T.InvID = TD.InvID Inner Join Mst_Item I On I.ItemID = TD.ItemID   Inner Join Mst_Tariff F On F.TariffID = I.TariffID Where T.InvDate Between @FromDt And @ToDate And T.PurchReturn = 'No'  Group By F.TariffID) FF On FF.TariffID = A.TariffID Group By a.TariffCode,A.Description,A.TariffID,FF.AssesableAmt Return End 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_Tariff](
	[TariffID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[TariffCode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Used] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
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
CREATE TABLE [dbo].[trn_TaxInvoiceDetails](
	[InvID] [numeric](18, 0) NULL,
	[ItemID] [numeric](18, 0) NULL,
	[Rate] [money] NULL,
	[Qty] [float] NULL,
	[Unit] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Amount] [money] NULL,
	[DiscAmt] [real] NULL,
	[Discount] [money] NULL,
	[PackAmt] [real] NULL,
	[Packing] [money] NULL,
	[PackingStd] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ItemSrno] [numeric](18, 0) NOT NULL,
	[POQty] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BalQty] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CastWeight] [float] NULL DEFAULT ((0)),
	[Schedules] [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CoId] [bigint] NULL,
	[ExchangeRate] [float] NULL
)

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
