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
