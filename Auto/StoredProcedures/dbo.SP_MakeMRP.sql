SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_Operation](
	[PSheetID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[PSheetNo] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[MakeDate] [datetime] NOT NULL,
	[ItemID] [numeric](18, 0) NOT NULL,
	[Active] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CScrap] [float] NULL,
	[PeriodFrom_CScrap] [datetime] NULL,
	[PeriodTo_CScrap] [datetime] NULL
)

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
CREATE TABLE [dbo].[Trn_WIPProd_Rework](
	[EntryID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[OutBy] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OutID] [numeric](18, 0) NOT NULL,
	[OutDate] [datetime] NOT NULL,
	[ItemID] [numeric](18, 0) NOT NULL,
	[OprnNo] [numeric](18, 0) NOT NULL,
	[OKQty] [float] NOT NULL,
	[CRej] [float] NOT NULL,
	[MRej] [float] NOT NULL,
	[POR] [float] NOT NULL,
	[Total] [float] NOT NULL,
	[PSheetID] [numeric](18, 0) NOT NULL,
	[RWReqEntry] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_WIPProd](
	[EntryID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[OutBy] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OutID] [numeric](18, 0) NOT NULL,
	[OutDate] [datetime] NOT NULL,
	[ItemID] [numeric](18, 0) NOT NULL,
	[OprnNo] [numeric](18, 0) NOT NULL,
	[OKQty] [float] NOT NULL,
	[CRej] [float] NOT NULL,
	[MRej] [float] NOT NULL,
	[POR] [float] NOT NULL,
	[Total] [float] NOT NULL,
	[PSheetID] [numeric](18, 0) NOT NULL,
	[RWReqEntry] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_WIPLoad_Rework](
	[EntryID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[InFrom] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[InID] [numeric](18, 0) NOT NULL,
	[InDate] [datetime] NOT NULL,
	[ItemID] [numeric](18, 0) NOT NULL,
	[OprnNo] [numeric](18, 0) NOT NULL,
	[WIP] [float] NULL,
	[PSheetID] [numeric](18, 0) NOT NULL,
	[RwDone] [float] NOT NULL,
	[NxtOprnNo] [numeric](18, 0) NOT NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_WIPLoad](
	[EntryID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[InFrom] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[InID] [numeric](18, 0) NOT NULL,
	[InDate] [datetime] NOT NULL,
	[ItemID] [numeric](18, 0) NOT NULL,
	[OprnNo] [numeric](18, 0) NOT NULL,
	[WIP] [float] NULL,
	[PSheetID] [numeric](18, 0) NOT NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_Temp4MRP](
	[SrNo] [bigint] IDENTITY(1,1) NOT NULL,
	[ItemID] [bigint] NOT NULL,
	[PlanQty] [float] NOT NULL,
	[Stock] [float] NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_StockOut](
	[EntryID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[OutBy] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OutID] [numeric](18, 0) NOT NULL,
	[OutDate] [datetime] NOT NULL,
	[OutQty] [float] NOT NULL,
	[ItemID] [numeric](18, 0) NOT NULL,
	[OutAs] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_StockIn](
	[EntryID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[InFrom] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[InID] [numeric](18, 0) NOT NULL,
	[InDate] [datetime] NOT NULL,
	[InQty] [float] NOT NULL,
	[ItemID] [numeric](18, 0) NOT NULL,
	[InAs] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_MRPPlannerDetails](
	[PRID] [bigint] NOT NULL,
	[SrNo] [int] NOT NULL,
	[ItemID] [bigint] NOT NULL,
	[POBal] [float] NULL,
	[SchBal] [float] NULL,
	[PlanQty] [float] NULL,
	[PtyName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PoNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Remarks] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 Create View Vw_4StockIn_CR as  Select Distinct ItemID,Sum(InQty) as CR_In from Trn_StockIn where InAs='CR' group by ItemID 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View Vw_4StockIn_MR as  Select Distinct ItemID,Sum(InQty) as MR_In from Trn_StockIn where InAs='MR' group by ItemID 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View Vw_4StockIn_Ok as  Select Distinct ItemID,Sum(InQty) as Ok_In from Trn_StockIn where InAs='OK' group by ItemID
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View Vw_4StockOut_CR as Select Distinct ItemID,Sum(OutQty) as CR_Out from Trn_StockOut where OutAs='CR' group by ItemID 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View Vw_4StockOut_MR as Select Distinct ItemID,Sum(OutQty) as MR_Out from Trn_StockOut where OutAs='MR' group by ItemID
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View Vw_4StockOut_Ok as  Select Distinct ItemID,Sum(OutQty) as Ok_Out from Trn_StockOut where OutAs='OK' group by ItemID 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View Vw_4WIP_Lvl as  Select Distinct L.ItemID,Sum(L.WIP) as Sum_Load,'IL' as Status from Trn_WIPLoad L Inner Join Mst_Operation O on L.PSheetID=O.PSheetID and O.Active='Yes' group by L.ItemID union all  Select Distinct L.ItemID,Sum(L.Total) as Sum_Load,'IP' as Status from Trn_WIPProd L Inner Join Mst_Operation O on L.PSheetID=O.PSheetID and O.Active='Yes' group by L.ItemID union all   Select Distinct L.ItemID,Sum(L.WIP) as Sum_Load,'RL' as Status from Trn_WIPLoad_Rework L Inner Join Mst_Operation O on L.PSheetID=O.PSheetID and O.Active='Yes' group by L.ItemID union all  Select Distinct L.ItemID,Sum(L.Total) as Sum_Load,'RP' as Status from Trn_WIPProd_Rework L Inner Join Mst_Operation O on L.PSheetID=O.PSheetID and O.Active='Yes' group by L.ItemID 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View Vw_4CurrStock as Select Distinct M.ItemID,Vw_4StockIn_Ok.Ok_In,Vw_4StockIn_CR.CR_In,Vw_4StockIn_MR.MR_In, Vw_4StockOut_Ok.Ok_Out,Vw_4StockOut_CR.CR_Out,Vw_4StockOut_MR.MR_Out,VIL.Sum_Load as IL,VIP.Sum_Load as IP,VRL.Sum_Load as RL,VRP.Sum_Load as RP from Mst_Item M Left Outer Join Vw_4StockIn_Ok on M.ItemID=Vw_4StockIn_Ok.ItemID Left Outer Join Vw_4StockIn_CR on M.ItemID=Vw_4StockIn_CR.ItemID Left Outer Join Vw_4StockIn_MR on M.ItemID=Vw_4StockIn_MR.ItemID Left Outer Join Vw_4StockOut_Ok on M.ItemID=Vw_4StockOut_Ok.ItemID Left Outer Join Vw_4StockOut_CR on M.ItemID=Vw_4StockOut_CR.ItemID Left Outer Join Vw_4StockOut_MR on M.ItemID=Vw_4StockOut_MR.ItemID Left Outer Join Vw_4WIP_Lvl VIL on M.ItemID=VIL.ItemID and VIL.Status='IL' Left Outer Join Vw_4WIP_Lvl VIP on M.ItemID=VIP.ItemID and VIP.Status='IP' Left Outer Join Vw_4WIP_Lvl VRL on M.ItemID=VRL.ItemID and VRL.Status='RL' Left Outer Join Vw_4WIP_Lvl VRP on M.ItemID=VRP.ItemID and VRP.Status='RP' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View Vw_4FinalStock as Select Distinct ItemID,'Ok_In'=case When Ok_In is not null then Ok_In When Ok_In is null then 0 end,'CR_In'= case When CR_In is not null then CR_In When CR_In is null then 0 end,'MR_In'=case When MR_In is not null then MR_In When MR_In is null then 0 end,'Ok_Out'= case When Ok_Out is not null then Ok_Out When Ok_Out is null then 0 end,'CR_Out'=case When CR_Out is not null then CR_Out When CR_Out is null then 0 end,'MR_Out'= case When MR_Out is not null then MR_Out When MR_Out is null then 0 end,'IL'= case When IL is not null then IL When IL is null then 0 end,'IP'= case When IP is not null then IP When IP is null then 0 end,'RL'= case When RL is not null then RL When RL is null then 0 end,'RP'= case When RP is not null then RP When RP is null then 0 End  From Vw_4CurrStock 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure SP_MakeMRP (@V_PRID Bigint) as declare @V_ItemId Bigint declare @V_PlanQty Float If (Cursor_Status('global','Csr_MRP') = -1 or Cursor_Status('local','Csr_MRP') = -1 ) Deallocate Csr_MRP declare Csr_MRP cursor for Select Distinct ItemID,Sum(PlanQty) as PlanQty from Trn_MRPPlannerDetails Where PRID=@V_PRID group by ItemID begin Truncate Table Trn_Temp4MRP Open Csr_MRP Fetch Next from Csr_MRP into @V_ItemID,@V_PlanQty while (@@fetch_status=0) begin insert into Trn_Temp4MRP(ItemID,PlanQty) Values(@V_ItemID,@V_PlanQty) Fetch Next from Csr_MRP into @V_ItemID,@V_PlanQty end Close Csr_MRP Update Trn_Temp4MRP Set Stock=Vw_4FinalStock.Ok_In+Vw_4FinalStock.IL+Vw_4FinalStock.RL-Vw_4FinalStock.Ok_Out-Vw_4FinalStock.IP-Vw_4FinalStock.RP from Vw_4FinalStock Where Trn_Temp4MRP.ItemID=Vw_4FinalStock.ItemID End
GO
