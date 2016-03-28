SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_Outward_57F4_BOM](
	[InvID] [numeric](18, 0) NOT NULL,
	[InvNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[InvDate] [datetime] NOT NULL,
	[CoID] [numeric](18, 0) NOT NULL,
	[ChID] [numeric](18, 0) NOT NULL,
	[ItemID] [numeric](18, 0) NOT NULL,
	[InvQty] [float] NOT NULL,
	[InvOrChallan] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_Inward_57F4_BOM](
	[ChID] [numeric](18, 0) NOT NULL,
	[CoID] [numeric](18, 0) NOT NULL,
	[ItemID] [numeric](18, 0) NOT NULL,
	[ChQty] [float] NOT NULL,
	[ActualQty] [float] NOT NULL
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
Create View Vw_457F4sRpt_BOM as Select Distinct Trn_Inward_57F4_BOM.ChID as ChallanID,Trn_Inward_57F4_BOM.ItemID,Trn_Inward_57F4_BOM.ChQty as ChallanQty,Trn_Inward_57F4_BOM.ActualQty, Mst_Item.IName,Mst_Item.IDrNum,Trn_57F4.ChallanNo,Trn_57F4.ChallanDate,Trn_57F4.PtyID,Trn_57F4.CoId,Mst_Party.AcName,Trn_Outward_57F4_BOM.InvID,Trn_Outward_57F4_BOM.InvNo,Trn_Outward_57F4_BOM.InvDate,Trn_Outward_57F4_BOM.InvQty from Trn_Inward_57F4_BOM Inner join Mst_Item on Trn_Inward_57F4_BOM.ItemID=Mst_Item.ItemId Inner Join Trn_57F4 on Trn_Inward_57F4_BOM.ChID=Trn_57F4.ChallanID Inner join Mst_Party On Trn_57F4.PtyID=Mst_Party.PtyID Left Outer Join Trn_Outward_57F4_BOM on Trn_Inward_57F4_BOM.ChID=Trn_Outward_57F4_BOM.ChID and Trn_Inward_57F4_BOM.ItemID=Trn_Outward_57F4_BOM.ItemID

GO
