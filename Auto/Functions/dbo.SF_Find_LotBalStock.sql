SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 Create Function SF_Find_LotBalStock()     Returns @Tmp_Result Table (LotId BigInt Not Null,LotNo Varchar(50),ItemId BigInt Not Null,  IName Varchar(50),LotBalQty Float Not Null)  As Begin   Declare @Tmp_StockIn Table(ItemId BigInt Not Null,InDate DateTime,LotId BigInt Not Null, LotNo Varchar(50),InQty Float Not Null)  Declare @Tmp_StockOut Table(ItemId BigInt Not Null,OutDate DateTime,LotId BigInt Not Null, LotNo Varchar(50),OutQty Float Not Null)  Insert Into @Tmp_StockIn(ItemId,InQty,InDate ,LotId , LotNo ) Select T.ItemId,InQty,T.InDate, IsNull(A.LotId,0),IsNull(A.LotNo,0) From Trn_StockLotIn T  Inner Join (Select Fl.InspId,FL.ItemId As IItemId,LT.LotId,LT.LotNo From Trn_GRNFinalLotDetails FL  Inner Join Trn_GRNFinal GF On GF.InspID = FL.InspId Inner Join Trn_Lot_No LT On LT.Lot_FromId = GF.InspID  And FL.ItemId = LT.ItemId And FL.LotNo = LT.LotNo Inner Join Mst_Item I On I.ItemID = Lt.ItemId) A On A.InspId = InId and A.IItemId = ItemId  And InFrom = 'GRN Final' and T.InAs = 'OK' Order By InDate Insert Into @Tmp_StockOut (ItemId,OutDate,LotId,OutQty,LotNo)  Select T.ItemId,T.OutDate,T.LotId,T.OutQty,TL.LotNo From Trn_StockLotOut T    Inner Join Trn_Lot_No TL On TL.LotId = T.LotId  Where T.OutAs = 'OK'  Insert Into @Tmp_Result(LotId,LotNo,ItemId,IName,LotBalQty) Select a.LotId ,a.LotNo, A.ItemId As ItemId,I.IName, Sum(A.TotalQty)  As LotBalQty From ( Select ItemId ,LotId ,LotNo,InQty As TotalQty From @Tmp_StockIn Union All Select ItemId,LotId ,LotNo,OutQty * -1 From @Tmp_StockOut) a  Inner Join Mst_Item I On I.ItemID = a.ItemId Group By a.LotId,A.ItemId,A.LotNo,I.IName Having  Sum(A.TotalQty) > 0  Return End 
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
CREATE TABLE [dbo].[Trn_StockLotOut](
	[EntryId] [bigint] IDENTITY(1,1) NOT NULL,
	[OutBy] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OutId] [bigint] NULL,
	[OutDate] [datetime] NULL,
	[OutQty] [float] NOT NULL,
	[ItemId] [bigint] NOT NULL,
	[LotId] [bigint] NOT NULL,
	[OutAs] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_StockLotIn](
	[EntryId] [bigint] IDENTITY(1,1) NOT NULL,
	[LotId] [bigint] NULL,
	[InFrom] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InId] [bigint] NULL,
	[InDate] [datetime] NULL,
	[ItemId] [bigint] NOT NULL,
	[InQty] [float] NOT NULL,
	[InAs] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_Lot_No](
	[LotId] [bigint] IDENTITY(1,1) NOT NULL,
	[Lot_Pre] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Lot_Suf] [bigint] NULL,
	[LotNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Lot_From] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Lot_FromId] [bigint] NOT NULL,
	[HeatNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ItemId] [bigint] NOT NULL,
	[Lot_Qty] [bigint] NOT NULL,
	[Lot_Unit] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
UNIQUE NONCLUSTERED 
(
	[LotNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_GRNFinalLotDetails](
	[InspId] [bigint] NOT NULL,
	[SrNo] [bigint] NOT NULL,
	[LotId] [bigint] NOT NULL,
	[ItemId] [bigint] NOT NULL,
	[HeatNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LotNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LotUnit] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LotQty] [float] NOT NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_GRNFinal](
	[InspID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[InspNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Inspdate] [datetime] NULL,
	[GrnID] [numeric](18, 0) NOT NULL,
	[GrnNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CoID] [numeric](18, 0) NULL,
	[GrnDate] [datetime] NULL,
	[PtyID] [numeric](18, 0) NULL,
	[PoNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PoDate] [datetime] NULL,
	[AmdNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AmdDate] [varchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ChallanNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ChallanDate] [datetime] NULL,
	[GrnType] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Transporter] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Vehicle] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InspectorID] [int] NULL,
	[PDINo] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PDIDate] [varchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Remark] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO
