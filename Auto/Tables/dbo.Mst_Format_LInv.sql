SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_Format_LInv](
	[CtrlType] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CtrlName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CtrlIndex] [int] NOT NULL,
	[Visible] [int] NOT NULL,
	[Left_D] [bigint] NOT NULL,
	[Top_D] [bigint] NOT NULL,
	[Height] [bigint] NOT NULL,
	[Width] [bigint] NOT NULL,
	[Font] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Size] [float] NOT NULL,
	[Color] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Bold] [int] NOT NULL,
	[Italic] [int] NOT NULL,
	[Underline] [int] NOT NULL
) ON [PRIMARY]

GO
