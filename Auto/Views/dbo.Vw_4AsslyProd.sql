SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_ProdEntryDetails](
	[ProdID] [numeric](18, 0) NOT NULL,
	[ItemID] [numeric](18, 0) NOT NULL,
	[Srno] [int] NULL,
	[OkQty] [float] NULL,
	[CRej] [float] NULL,
	[MRej] [float] NULL,
	[PORej] [float] NULL,
	[Rework] [float] NULL,
	[TQty] [float] NULL,
	[Remarks] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BatchNo] [numeric](18, 0) NULL,
	[BatchQty] [float] NULL,
	[IssueBal] [float] NULL,
	[ProdBal] [float] NULL,
	[Unit] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_BOMIssueDetails](
	[Srno] [numeric](18, 0) NULL,
	[IssueID] [numeric](18, 0) NULL,
	[PartID] [numeric](18, 0) NULL,
	[Unit] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IntendQty] [float] NULL,
	[IssuedQty] [float] NULL,
	[ExtraIntend] [float] NULL,
	[ExtraIssued] [float] NULL,
	[RejID] [numeric](18, 0) NULL,
	[PrevStock] [float] NULL,
	[Sum_Issued] [float] NULL
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_BOMIssue](
	[IssueID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[IssueNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IssueDate] [datetime] NULL,
	[IssueTime] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Rcvdby] [numeric](18, 0) NULL,
	[Issuedby] [numeric](18, 0) NULL,
	[AsslyID] [numeric](18, 0) NULL,
	[BatchQty] [float] NULL,
	[Unit] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Produced] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BatchNo] [numeric](18, 0) NULL,
	[Status] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IssueOption] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastYearID] [bigint] NULL
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View Vw_4Batch_BOMI as select Trn_BOMIssue.BatchNo,Trn_BOMIssue.AsslyID,Trn_BOMIssue.IssueDate,Trn_BOMIssue.BatchQty,Trn_BOMIssuedetails.Srno,Trn_BOMIssuedetails.PartId,Trn_BOMIssueDetails.IntendQty from Trn_BOMIssue Inner join Trn_BOMIssueDetails on Trn_BOMIssue.IssueID=Trn_BOMIssueDetails.IssueID where Trn_BOMIssue.Status='First' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View Vw_4BatchTot_BOMI as select distinct Vw_4Batch_BOMI.PartID,Vw_4Batch_BOMI.Srno,Vw_4Batch_BOMI.IntendQty,Vw_4Batch_BOMI.BatchNo,Vw_4Batch_BOMI.Issuedate,Vw_4Batch_BOMI.AsslyID,Vw_4Batch_BOMI.BatchQty,Sum(Trn_BOMIssueDetails.IssuedQty) as Sum_Issued from Vw_4Batch_BOMI inner join Trn_BOMIssue on Vw_4Batch_BOMI.BatchNo=Trn_BOMIssue.Batchno inner join Trn_BOMIssueDetails on Trn_BOMIssue.IssueID=Trn_BOMIssueDetails.IssueId and Vw_4Batch_BOMI.PartID=Trn_BOMIssueDetails.PartID Group by Vw_4Batch_BOMI.PartId,Vw_4Batch_BOMI.BatchNo, Vw_4Batch_BOMI.AsslyID,Vw_4Batch_BOMI.BatchQty,Vw_4Batch_BOMI.Issuedate,Vw_4Batch_BOMI.IntendQty,Vw_4Batch_BOMI.Srno
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view Vw_4AsslyProd_Batch as Select Distinct Vw_4BatchTot_BOMI.BatchNo,Vw_4BatchTot_BOMI.BatchQty,Vw_4BatchTot_BOMI.AsslyID, Min(Sum_Issued/IntendQty) as BatchQty_Issued from Vw_4BatchTot_BOMI Group by  Vw_4BatchTot_BOMI.BatchNo,Vw_4BatchTot_BOMI.BatchQty,Vw_4BatchTot_BOMI.AsslyID
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create view  Vw_4AsslyProd as Select Distinct Vw_4AsslyProd_Batch.BatchNo,Vw_4AsslyProd_Batch.BatchQty,Vw_4AsslyProd_Batch.AsslyID, Vw_4AsslyProd_Batch.BatchQty_Issued, Sum(Trn_ProdEntryDetails.TQty) as Sum_Produced  from Vw_4AsslyProd_Batch inner join Trn_ProdEntryDetails on Vw_4AsslyProd_Batch.BatchNo=Trn_ProdEntryDetails.BatchNo  and Vw_4AsslyProd_Batch.AsslyID=Trn_ProdEntryDetails.ItemID group by  Vw_4AsslyProd_Batch.BatchNo,Vw_4AsslyProd_Batch.BatchQty,Vw_4AsslyProd_Batch.AsslyID,Vw_4AsslyProd_Batch.BatchQty_Issued
GO
