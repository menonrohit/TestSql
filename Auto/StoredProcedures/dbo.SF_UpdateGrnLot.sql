SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 Create Function SF_GetLotNo (@Lot_Date DateTime)  Returns @Tmp_GetLotNo Table (Lot_Pre Varchar(50) Not Null,  Lot_Suf BigInt Not Null,Lot_No Varchar(50) Not Null) As Begin  Declare @Lot_Suf BigInt, @Lot_No Varchar(50),@Lot_Pre Varchar(50)  Select @Lot_Pre=Convert(Varchar,@Lot_Date,106)  Set @Lot_Pre  = Left(@Lot_Pre,2) +  Upper(SubString(@Lot_Pre,4,3)) + Right(@Lot_Pre,2)  Select @Lot_Suf = Max(Lot_Suf) From Trn_Lot_No Where Lot_Pre=@Lot_Pre  If @Lot_Suf Is Null Set @Lot_Suf=1 Else Set @Lot_Suf=@Lot_Suf +1  Insert Into @Tmp_GetLotNo (Lot_Pre,Lot_Suf,Lot_No) Select Replace(@Lot_Pre,' ' ,''),  @Lot_Suf,Replace(@Lot_Pre,' ','') +'-'+Convert(Varchar,@Lot_Suf) Return End 
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
CREATE TABLE [dbo].[Trn_GRNFinalDetails](
	[Srno] [int] NULL,
	[InspID] [numeric](18, 0) NULL,
	[ItemID] [numeric](18, 0) NULL,
	[ChallanQty] [float] NULL,
	[Unit] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RcvdQty] [float] NULL,
	[CurrStock] [float] NULL,
	[PrevStock] [float] NULL,
	[OKQty] [float] NULL,
	[MRejection] [float] NULL,
	[CRejection] [float] NULL,
	[PORejection] [float] NULL,
	[OtherRejection] [float] NULL,
	[Returned] [float] NULL,
	[MRejID] [numeric](18, 0) NULL,
	[CRejID] [numeric](18, 0) NULL,
	[PORejID] [numeric](18, 0) NULL,
	[OtherRejID] [numeric](18, 0) NULL,
	[ReworkQty] [float] NULL,
	[ReturnedRejID] [numeric](18, 0) NULL,
	[ReworkRejID] [numeric](18, 0) NULL,
	[RouteId] [bigint] NULL
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
 Create Proc SF_UpdateGrnLot @InspId BigInt ,@SaveFlag Varchar(1) As Begin Begin Tran Begin Try  Declare @GRNDate DateTime,@Lot_Suf BigInt , @Lot_Pre Varchar(50) Declare @LotId BigInt, @Failed Smallint Set @LotId = 0 Set @Failed = 0 Select @GRNDate = InspDate From Trn_GRNFinal Where InspID = @InspId  Select @Lot_Pre=Lot_Pre, @Lot_Suf = Lot_Suf From SF_GetLotNo(@GRNDate) Set @Lot_Suf = @Lot_Suf -1 Delete From Trn_StockLotIn Where InId = @InspId And InFrom = 'GRN Final' Delete From Trn_StockLotOut Where OutId = @InspId And OutBy = 'GRN Final'  If @SaveFlag = 'I' Begin Insert Into Trn_GRNFinalLotDetails(InspId,SrNo,ItemId,HeatNo,LotNo,LotUnit,LotQty,LotId) Select @InspId,ROW_NUMBER() Over(Order By SrNo),ItemID,'', @Lot_Pre + '-' + Convert(Varchar,@Lot_Suf+ROW_NUMBER() Over(Order By SrNo)),Unit,  RcvdQty,0 From Trn_GRNFinalDetails Where InspID = @InspId Insert Into Trn_Lot_No(Lot_Pre,Lot_Suf,LotNo,Lot_From,Lot_FromId,HeatNo,ItemId,Lot_Qty,Lot_Unit)  Select @Lot_Pre,@Lot_Suf + Row_Number() Over(Order By SrNo),LotNo,P.PtyName, @InspId,GD.HeatNo,ItemId,LotQty,LotUnit From Trn_GRNFinalLotDetails GD  Inner Join Trn_GRNFinal GF On GD.InspId = GF.InspId And GF.InspID = @InspId Inner Join Mst_Party P On P.PtyID = GF.PtyID Order By SrNo Update Trn_GRNFinalLotDetails Set LotID = a.LLotId From(Select L.LotId As LLotId,L.ItemId As IItemId,L.LotNo As LLotNo From Trn_Lot_No L  Inner Join Trn_GRNFinalLotDetails LD On LD.ItemId = L.ItemId And InspId = @InspId And LD.LotNo = L.LotNo) A Where A.IItemId = ItemId and LotNo = A.LLotNo  and InspId = @InspId  End  Else Begin Update Trn_Lot_No Set Lot_Qty= a.LLotQty , HeatNo= A.HHeatNo From ( Select ItemId As IItemId,LotQty As LLotQty,GD.HeatNo As HHeatNo From Trn_GRNFinalLotDetails GD  Inner Join Trn_GRNFinal GF On GD.InspId = GF.InspId And GF.InspID = @InspId) a Where a.IItemId = ItemId And Lot_FromId = @InspId End Insert Into Trn_StockLotIn(InFrom,InId,LotId,InDate,ItemId,InQty,InAs) Select 'GRN Final',@InspId,LD.LotId,F.GrnDate,Fd.ItemID,FD.OKQty+ReworkQty As LotQty,'OK'  From Trn_GRNFinalDetails FD Inner Join Trn_GRNFinalLotDetails LD On LD.InspId = FD.InspID And FD.ItemID = LD.ItemId Inner Join Trn_GRNFinal F On F.InspID = FD.InspID And F.InspID = @InspId Insert Into Trn_StockLotOut(OutBy,OutId,LotId,OutDate,ItemId,OutQty,OutAs)  Select 'GRN Final',@InspId,LD.LotId,F.GrnDate,Fd.ItemID,FD.OtherRejection As LotRejctQty,'MR' From Trn_GRNFinalDetails FD  Inner Join Trn_GRNFinalLotDetails LD On LD.InspId = FD.InspID And FD.ItemID = LD.ItemId Inner Join Trn_GRNFinal F On   F.InspID = FD.InspID And F.InspID = @InspId And FD.OtherRejection > 0 End Try Begin Catch Set @Failed=1 End Catch If @Failed=0  Begin Commit Tran End Else Rollback Tran Return  End  
GO
