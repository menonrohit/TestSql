SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_ListMachinery](
	[MachID] [bigint] IDENTITY(1,1) NOT NULL,
	[ISO_MR] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[App_CEO] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Sign1] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Sign2] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Ref_No] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Issue_No_Date] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Rev_No_Date] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]

GO
