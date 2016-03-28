SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 Create Function SF_DailyStockkRG1(@ItemId BigInt,@StartDate DateTime ) Returns     @Tmp_Result Table (SrNo BigInt Identity(1,1),EntryDate DateTime Not Null,InvId BigInt,  ItemId BigInt,OpeningBal Float,QtyManu Float,HomeQty Float,HomeValue Float,ExpTaxQty Float, ExpTaxValue Float,ExpWTaxQty Float,ExpWTaxValue Float,Rate Float,Amount Float,Edu_Cess Float,SH_Cess Float,DutyPaid Float)  As Begin Declare @Tmp_Taxes Table (InvId BigInt,InvDate DateTime,TaxName Varchar(100),Value Float,TaxAmount Float) Declare @EndDate DateTime Set @EndDate = DateAdd(MM,1,@StartDate) Set @EndDate = DateAdd(DD,-1,@EndDate) While @EndDate >= @StartDate Begin Insert Into @Tmp_Result    (EntryDate,ItemId,InvId,OpeningBal,QtyManu,HomeQty,HomeValue, ExpTaxQty,ExpTaxValue,ExpWTaxQty,ExpWTaxValue,Rate,Amount,Edu_Cess,SH_Cess) Select @StartDate,@ItemId,0,0,0,0,0,0,0,0,0,0,0,0,0  Set @StartDate = DateAdd(dd,1,@Startdate) End Update @Tmp_Result Set QtyManu= a.QtyManu From (Select T.InvDate, Td.ItemID As IItemId,Sum(Qty) As QtyManu From Trn_TaxInvoiceDetails TD Inner Join Trn_TaxInvoice T On T.InvID = TD.InvID Where Td.ItemID =@ItemId Group By TD.ItemID,T.InvDate) A  Where A.InvDate = EntryDate And A.IItemId = ItemId Update @Tmp_Result Set HomeQty= B.Qty, HomeValue = B.Value From (  Select A.InvDate,Sum(Qty) As Qty,Sum(Value) As Value From (Select T.InvDate, Td.Qty, (Rate*Qty) - ((Rate*Qty) / 100 * T1.Discount) + IsNull(Td.PackAmt,0) As Value From Trn_TaxInvoiceDetails TD Inner Join Trn_TaxInvoice T On T.InvID = TD.InvID Inner Join trn_CustOrder C On C.CoID = TD.CoId Inner Join (Select T1.InvID,Max(T1.Discount) As Discount From Trn_TaxInvoiceDetails T1  Inner Join Trn_TaxInvoice T2 On T1.InvID = T2.InvID Group By T1.InvID) T1 On T1.InvID = T.InvID Where TD.ItemID = @ItemId And C.CurrencyId = 0) A Group By A.InvDate) B Where B.InvDate = EntryDate Update @Tmp_Result Set ExpTaxQty = C.Qty,ExpTaxValue = C.Value From (  Select A.InvDate,Sum(Qty) As Qty,Sum(Value) As Value From (Select T.InvDate, Td.Qty, (Rate*Qty) - ((Rate*Qty) / 100 * T1.Discount) + IsNull(Td.PackAmt,0) As Value From Trn_TaxInvoiceDetails TD Inner Join Trn_TaxInvoice T On T.InvID = TD.InvID Inner Join trn_CustOrder C On C.CoID = TD.CoId Inner Join (Select T1.InvID,Max(T1.Discount) As Discount From Trn_TaxInvoiceDetails T1  Inner Join Trn_TaxInvoice T2 On T1.InvID = T2.InvID Group By T1.InvID) T1 On T1.InvID = T.InvID Inner Join (Select InvId,Sum(TaxAmount) As TaxAmount From Trn_TaxInvoiceTaxes Group By InvID) Tx On Tx.InvID = T.InvID Where TD.ItemID = @ItemId And C.CurrencyId > 0 and Tx.TaxAmount > 0) A Group By A.InvDate) C Where C.InvDate = EntryDate  Update @Tmp_Result Set ExpWTaxQty = C.Qty,ExpWTaxValue = C.Value From (Select A.InvDate,Sum(Qty) As Qty,Sum(Value) As Value From ( Select T.InvDate, Td.Qty, (Rate*Qty) - ((Rate*Qty) / 100 * T1.Discount) + IsNull(Td.PackAmt,0)  As Value From Trn_TaxInvoiceDetails TD Inner Join Trn_TaxInvoice T On T.InvID = TD.InvID Inner Join trn_CustOrder C On C.CoID = TD.CoId Inner Join (Select T1.InvID,Max(T1.Discount) As Discount From Trn_TaxInvoiceDetails T1  Inner Join Trn_TaxInvoice T2 On T1.InvID = T2.InvID Group By T1.InvID) T1 On T1.InvID = T.InvID Inner Join (Select InvId,Sum(TaxAmount) As TaxAmount From Trn_TaxInvoiceTaxes Group By InvID) Tx On Tx.InvID = T.InvID Where TD.ItemID = @ItemId And C.CurrencyId > 0 and Tx.TaxAmount = 0) A Group By A.InvDate) C Where C.InvDate = EntryDate  Insert Into @Tmp_Taxes(InvId,InvDate,TaxName,Value,TaxAmount) Select T.InvID,T.InvDate,Tx.TaxName,M.Value, Tx.TaxAmount As TaxAmount From Trn_TaxInvoiceTaxes Tx Inner Join Trn_TaxInvoice T on Tx.InvID = T.InvID Inner Join trn_TaxInvoiceDetails Td On Td.InvID = T.InvID  Inner Join Mst_Tax M On M.TaxID = Tx.TaxID Where TaxName Like '%Excise%' Or TaxName Like '%Edu%' Or TaxName Like 'E  Cess%' Or TaxName Like 'E Cess%'  Or TaxName Like '%HE Cess%' Or TaxName Like '%HS%' Order By SrNo  Update @Tmp_Result Set Amount = A.TaxAmount,Rate = A.Value From (Select InvDate as IInvDate,TaxName,Value,SUM(TaxAmount) As TaxAmount From @Tmp_Taxes Where TaxName Like '%Excise%' Group By InvDate,TaxName,Value ) a Where A.IInvDate = EntryDate Update @Tmp_Result Set Edu_Cess = A.TaxAmount From (Select InvDate,TaxName,Value,SUM(TaxAmount) As TaxAmount From @Tmp_Taxes Where TaxName Like '%Edu%' Or TaxName Like 'E  Cess%' Or TaxName Like 'E Cess%'  Group By InvDate,TaxName,Value ) a Where A.InvDate = EntryDate  Update @Tmp_Result Set SH_Cess = A.TaxAmount From (Select InvDate,TaxName,Value,SUM(TaxAmount) As TaxAmount From @Tmp_Taxes Where TaxName Like '%HS%' Or TaxName Like '%HE Cess%' Group By InvDate,TaxName,Value ) a Where A.InvDate = EntryDate Update @Tmp_Result Set DutyPaid = Amount+Edu_Cess+SH_Cess Return End 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_Tax](
	[TaxID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[TaxOrCharge] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FixedOrPercent] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Value] [money] NOT NULL,
	[AcID] [numeric](18, 0) NULL,
	[Used] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PrintDisplay] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Priority] [numeric](18, 0) NULL,
	[TaxGroup] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Acid1] [bigint] NULL DEFAULT ((0)),
	[Acid2] [bigint] NULL DEFAULT ((0)),
	[Acid3] [bigint] NULL DEFAULT ((0)),
	[Perct] [float] NULL,
	[Perct1] [float] NULL,
	[Perct2] [float] NULL,
	[Perct3] [float] NULL
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
CREATE TABLE [dbo].[trn_CustOrder](
	[CoID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[Pono] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Vno] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[QuotNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_trn_CustOrder_Quotno]  DEFAULT (0),
	[CoDate] [datetime] NULL,
	[CoType] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[QtyType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TypeID] [numeric](18, 0) NULL,
	[ItemType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Total] [money] NULL CONSTRAINT [DF_trn_CustOrder_Total]  DEFAULT (0),
	[Cancelled] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ValidFrom] [datetime] NULL,
	[ValidTo] [datetime] NULL,
	[PaymentDays] [int] NULL,
	[Freight] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DeliveryChallan] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CancelledDate] [datetime] NULL,
	[InvType] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastYearID] [numeric](18, 0) NULL,
	[ROffFlag] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RateDiffFlag] [int] NULL,
	[CurrencyId] [bigint] NULL
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
CREATE TABLE [dbo].[trn_TaxInvoiceTaxes](
	[InvID] [numeric](18, 0) NULL,
	[TaxID] [numeric](18, 0) NULL,
	[TaxName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Taxpercent] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TaxAmount] [money] NULL,
	[Srno] [numeric](18, 0) IDENTITY(1,1) NOT NULL
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
