/****** Cannot script Unresolved Entities : Server[@Name='DESKTOP-QHA6FLQ\SQLEXPRESSADV']/Database[@Name='Auto']/UnresolvedEntity[@Name='Mst_Company'] ******/
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 Create Function SF_PendingExportOrders() Returns @Tmp_PedningSchdule Table (CoId BigInt Not Null,CAmdId BigInt Not Null,PtyId BigInt Not Null, PartyName Varchar(100),PONo Varchar(200), SrNo BigInt Not Null, ItemId BigInt Not Null,IName Varchar(150) Not Null,SchQty Float Not Null,SchDate DateTime,InvQty Float Not Null)  As Begin Declare @BalStock Numeric(16,2) Declare @CoId BigInt Declare @RowNo BigInt Declare @SrNo SmallInt Declare @ItemId BigInt Set @BalStock = 0 Set @RowNo = 0 Set @SrNo = 0  Set @ItemId = 0 Declare @Tmp_InvoicedSumary Table (RowNo BigInt Identity(1,1),PtyId BigInt Not Null, PartyName Varchar(100),CoId BigInt Not Null,SrNo BigInt Not Null, ItemId BigInt Not Null,   IName Varchar(100) Not Null,InvQty Float Not Null) Declare @Tmp_InvoicedItems Table (RowNo BigInt Identity(1,1),InvId BigInt Not Null,InvDate DateTime Not Null,PtyId BigInt Not Null, PartyName Varchar(100),CoId BigInt Not Null,PONo Varchar(200),SrNo BigInt Not Null, ItemId BigInt Not Null, IName Varchar(100) Not Null,InvQty Float Not Null) Insert Into @Tmp_PedningSchdule(CoId,PtyId,PartyName,CAmdId,PONo,SrNo,ItemId,IName,SchQty,SchDate,InvQty) Select C.CoID,C.PtyID,P.PtyName,0 As CAmdId,C.PONo As AmdNo, ROW_NUMBER() Over(Order By Cs.SchDate,Cs.SchQty) As SrNo,CS.ItemID,IName,CS.SchQty,CS.SchDate,0 As InvQty From Trn_CustOrderSchedule CS Inner Join Trn_CustOrder C On C.CoID = CS.CoID Inner Join Mst_Party P On P.PtyID = C.PtyID Inner Join Mst_Item I On I.ItemId = Cs.ItemId  Where C.Cancelled='No' and C.CoType='Normal' And C.CoID Not In (Select CoID From Trn_CustAmd Where CoType = 'Normal') Order By SchDate Insert Into @Tmp_PedningSchdule(CoId,PtyId,PartyName,CAmdId,PONo,SrNo,ItemId,Iname,SchQty,SchDate,InvQty) Select C.CoID,Cs.PtyID,P.PtyName,Cs.CAmdID,Cs.AmdNo,ROW_NUMBER() Over (Order By Cs1.SchDate,Cs1.SchQty) As SrNo, Cs1.ItemId,I.IName,CS1.SchQty,CS1.SchDate,0 As InvQty From Trn_CustAmdSchedule CS1  Inner Join Trn_CustAmd CS On CS.CAmdID = CS1.CAmdID Inner Join Mst_Party P On P.PtyID = CS.PtyID  Inner Join trn_CustOrder C On C.CoID = CS.CoID Inner Join Mst_Item I On I.ItemId = Cs1.ItemId Where C.Cancelled='No' and C.CoType='Normal' Order By SchDate Insert Into @Tmp_InvoicedItems (InvId,InvDate,PtyId,PartyName,CoId,PONo,SrNo,ItemId,IName,InvQty) Select T.InvID,T.InvDate,T.PtyID,P.PtyName,C.CoId,C.Pono,TD.ItemSrno,TD.ItemID,I.Iname,TD.Qty From Trn_TaxInvoice T Inner Join Trn_TaxInvoiceDetails TD On T.InvID = TD.InvID Inner Join Trn_CustOrder C On C.CoId = T.CoID And T.PtyID = C.PtyID Inner Join Mst_Party P On P.PtyID = C.PtyID Inner Join Mst_Item I On I.ItemID = Td.ItemId Where C.CoType ='Normal' And TD.CoId = 0 Order By T.InvDate  Insert Into @Tmp_InvoicedItems (InvId,InvDate,PtyId,PartyName,CoId,PONo,SrNo,ItemId,IName,InvQty) Select T.InvID,T.InvDate,T.PtyID,P.PtyName,TD.CoId,C.Pono,TD.ItemSrno,TD.ItemID,I.IName, TD.Qty From Trn_TaxInvoice T Inner Join trn_TaxInvoiceDetails TD On T.InvID = TD.InvID Inner Join trn_CustOrder C On C.CoId = TD.CoID And T.PtyID = C.PtyID Inner Join Mst_Party P On P.PtyID = C.PtyID Inner Join Mst_Item I On I.ItemID = Td.ItemId Where C.CoType ='Normal' Order By T.InvDate Insert Into @Tmp_InvoicedSumary(PtyId,PartyName,CoId,SrNo,ItemId,IName,InvQty )  Select PtyId,PartyName,CoId,ROW_NUMBER() Over (Order By SrNo),ItemId,IName,Sum(InvQty) From @Tmp_InvoicedItems  Group By CoId,ItemId,Iname,PtyId,PartyName,SrNo Delete From @Tmp_InvoicedSumary Where CoId Not In (Select Distinct CoId From @Tmp_PedningSchdule) Select @RowNo = Min(RowNo) From @Tmp_InvoicedSumary Tx While @RowNo > 0  and @RowNo Is Not Null Begin Select @ItemId = ItemId From @Tmp_InvoicedSumary Where RowNo = @RowNo Select @CoId = CoId From @Tmp_InvoicedSumary Where RowNo = @RowNo  Select @BalStock = Invqty From @Tmp_InvoicedSumary Where RowNo = @RowNo While @BalStock > 0 Begin Select @SrNo =Min(SrNo) From @Tmp_PedningSchdule Where CoId = @CoId and ItemId = @ItemId and InvQty < SchQty If @SrNo Is Null Or @SrNo <= 0 Begin Set @SrNo = 0 Set @BalStock = 0 End if @BalStock >= (Select SUM(SchQty) From @Tmp_PedningSchdule Where CoId = @CoId and ItemId = @ItemId Group By ItemId,CoId) Begin Set @BalStock = 0 Update @Tmp_PedningSchdule Set InvQty = SchQty Where CoId = @CoId and ItemId = @ItemId  End Else If @BalStock <= (Select SchQty - InvQty From @Tmp_PedningSchdule Where ItemId = @ItemId and CoId = @CoId and Srno = @SrNo) Begin Update @Tmp_PedningSchdule Set InvQty = InvQty + @BalStock Where CoId = @CoId and ItemId = @ItemId And SrNo = @SrNo End Else If @BalStock > (Select Schqty+InvQty From @Tmp_PedningSchdule Where ItemId = @ItemId and CoId = @CoId and Srno = @SrNo) Begin Update @Tmp_PedningSchdule Set InvQty = SchQty Where CoId = @CoId and ItemId = @ItemId And SrNo = @SrNo End  if @BalStock > 0 Begin Select @BalStock = Sum(InvQty) From @Tmp_InvoicedSumary Where RowNo =@RowNo Select @BalStock = @BalStock - Sum(InvQty) From @Tmp_PedningSchdule Where CoId = @CoId And ItemId = @ItemId Group By ItemId,CoId End  If @BalStock < 0 or @BalStock Is Null  Begin Set @BalStock = 0 End End If @BalStock = 0 Begin Select @RowNo = Min(RowNo) From @Tmp_InvoicedSumary Where RowNo > @RowNo If @RowNo Is Null or @RowNo = 0 Begin Set @BalStock = 0 End End End Return End  
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 Create Function SF_DeliveryAlerts()  Returns @Tmp_MainResult Table (CoId BigInt Not Null,CAmdId BigInt Not Null,PtyId BigInt Not Null,PONo Varchar(100),PartyName Varchar(100) Not Null,    SrNo Float ,ItemID BigInt Not Null,IName Varchar(200) Not Null,SchQty Float ,SchDate DateTime)    As Begin Declare @AlertDays SmallInt Declare @AlertDate SmallDateTime  Select @AlertDays = IsNull(DeliveryAlert,0) From Mst_Company   Set @AlertDate =DateAdd(DD,@AlertDays,Getdate()) Set @AlertDate = Convert(VARCHAR,@AlertDate,110)   Insert Into @Tmp_MainResult (CoId,CAmdId,PtyId,PONo,PartyName,SrNo,ItemID,IName,SchQty,SchDate)   Select CoId,CAmdId,PtyId,PONo,PartyName,SrNo,PO.ItemID,PO.IName + ' #' + I.IDrnum  ,SchQty - InvQty ,SchDate   From SF_PendingExportOrders() PO Inner Join Mst_Item I On I.ITemID = PO.ITemId  Where SchQty > InvQty And SchDate <= @AlertDate Return End 
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
CREATE TABLE [dbo].[trn_CustOrderSchedule](
	[CoID] [numeric](18, 0) NULL,
	[SrNo] [numeric](18, 0) NULL,
	[ItemID] [numeric](18, 0) NULL,
	[SchQty] [float] NULL,
	[SchDate] [datetime] NULL,
	[SheduleNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

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
CREATE TABLE [dbo].[trn_CustAmdSchedule](
	[CAmdID] [numeric](18, 0) NULL,
	[SRno] [numeric](18, 0) NULL,
	[ItemID] [numeric](18, 0) NULL,
	[SchQty] [float] NULL,
	[SchDate] [datetime] NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[trn_CustAmd](
	[Vno] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CAmdID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[CoID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PoNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CoDate] [datetime] NULL,
	[PtyID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AmdDate] [datetime] NULL,
	[ValidFrom] [datetime] NULL,
	[ValidTo] [datetime] NULL,
	[CoType] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TypeID] [numeric](18, 0) NULL,
	[ItemType] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PaymentDays] [numeric](18, 0) NULL CONSTRAINT [DF_trn_CustAmd_PaymentTerms]  DEFAULT (0),
	[Freight] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[QtyType] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AmdNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Total] [money] NULL CONSTRAINT [DF_trn_CustAmd_Total]  DEFAULT (0),
	[Cancelled] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
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
