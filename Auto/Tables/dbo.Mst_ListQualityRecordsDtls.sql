SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_ListQualityRecordsDtls](
	[QtyID] [bigint] NOT NULL,
	[SrNo] [bigint] NOT NULL,
	[Desc_Records] [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RefNo] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Indexing] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Responsiblty] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Ret_Period] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]

GO
