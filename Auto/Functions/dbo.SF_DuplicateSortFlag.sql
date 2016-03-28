SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 Create Function SF_DuplicateSortFlag(@SubGroupId As BigInt , @SortFlag Varchar(20)) Returns @ResultTable Table(GrpId BigInt ,  GroupName Varchar(100)) As Begin Insert Into @ResultTable(GrpId,GroupName) Select GrpID , GrpName From Mst_Grp_Accounts  Where SubGrpID = @SubGroupId And SortFlag = @SortFlag Return End  
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_Grp_Accounts](
	[GrpID] [bigint] IDENTITY(1,1) NOT NULL,
	[GrpName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[BaseGrpName] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SubGrpID] [bigint] NOT NULL,
	[SubGrpName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UserEdit] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TallyGrpName] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SortFlag] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
