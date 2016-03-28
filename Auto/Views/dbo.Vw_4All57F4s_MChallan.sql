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
CREATE TABLE [dbo].[Trn_57F4s_LOutChallan](
	[OutChID] [numeric](18, 0) NOT NULL,
	[CoID] [numeric](18, 0) NOT NULL,
	[Srno] [int] NOT NULL,
	[ItemID] [numeric](18, 0) NOT NULL,
	[ChID] [numeric](18, 0) NOT NULL,
	[ChNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ChDate] [datetime] NOT NULL,
	[RcvdQty] [float] NULL,
	[PrevBal] [float] NULL,
	[DespatchQty] [float] NULL,
	[CurrBal] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_57F4Details](
	[ChallanID] [numeric](18, 0) NULL,
	[ItemID] [numeric](18, 0) NULL,
	[PoQty] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_Trn_57F4Details_PoQty]  DEFAULT (0),
	[BalQty] [float] NULL CONSTRAINT [DF_Trn_57F4Details_BalQty]  DEFAULT (0),
	[ChallanQty] [float] NULL CONSTRAINT [DF_Trn_57F4Details_ChallanQty]  DEFAULT (0),
	[Unit] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShortQty] [float] NULL CONSTRAINT [DF_Trn_57F4Details_ShortQty]  DEFAULT (0),
	[ActualQty] [float] NULL CONSTRAINT [DF_Trn_57F4Details_ActualQty]  DEFAULT (0),
	[ExcessQty] [float] NULL CONSTRAINT [DF_Trn_57F4Details_ExcessQty]  DEFAULT (0),
	[Srno] [int] NULL,
	[FromLastYear] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[trn_57f4](
	[Vno] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ChallanID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[CoId] [numeric](18, 0) NULL,
	[PtyID] [numeric](18, 0) NULL,
	[ChallanNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ChallanDate] [datetime] NULL,
	[Completed] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_trn_57f4_Completed]  DEFAULT (0),
	[FromOrder] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF_trn_57f4_FromOrder]  DEFAULT (0),
	[ChallanType] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastYearID] [numeric](18, 0) NULL,
	[ForRework] [int] NULL,
	[BOMItems] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ForConv] [int] NULL
) ON [PRIMARY]

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
Create View Vw_57F4Details as  Select Trn_57F4.ChallanNo,Trn_57F4.ChallanDate,Trn_57F4.ChallanID,Trn_57F4.ForConv,Trn_CustOrder.CoID, Trn_CustOrder.CoType,Trn_CustOrder.InvType,Trn_CustOrder.PtyID,Mst_Party.AcName,Trn_57F4Details.ItemID, Mst_Item.IName,Mst_Item.IDrNum,Mst_Item.ILMeasure as Unit,Trn_57F4Details.ChallanQty,Trn_57F4Details.ActualQty FROM trn_57f4 INNER JOIN Trn_CustOrder ON Trn_CustOrder.CoID = trn_57f4.CoId Inner join Mst_Party on Trn_CustOrder.PtyID=Mst_Party.PtyID INNER JOIN Trn_57F4Details ON Trn_57f4.ChallanID = Trn_57F4Details.ChallanID INNER JOIN Mst_Item ON Mst_Item.ItemID = Trn_57F4Details.ItemID Where Trn_CustOrder.CoType='Jobwork' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View Vw_4All57F4s_MChallan as select Distinct Vw_57F4Details.ChallanID,Vw_57F4Details.ChallanNo,Vw_57F4Details.ChallanDate,Vw_57F4Details.CoID, Vw_57F4Details.ItemID,Vw_57F4Details.IName,Vw_57F4Details.IDrNum,Vw_57F4Details.ChallanQty,Vw_57F4Details.ActualQty,Sum(Trn_57F4s_LOutChallan.DesPatchQty) as Sum_Despatch from Vw_57F4Details Left Outer Join Trn_57F4s_LOutChallan on Vw_57F4Details.CoID=Trn_57F4s_LOutChallan.CoID and Vw_57F4Details.ChallanID=Trn_57F4s_LOutChallan.ChID and Vw_57F4Details.ItemID=Trn_57F4s_LOutChallan.ItemID group by Vw_57F4Details.ChallanID,Vw_57F4Details.ChallanNo,Vw_57F4Details.ChallanDate,Vw_57F4Details.CoID, Vw_57F4Details.ItemID,Vw_57F4Details.IName,Vw_57F4Details.IDrNum,Vw_57F4Details.ChallanQty, Vw_57F4Details.ActualQty 
GO
