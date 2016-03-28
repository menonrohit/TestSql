SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_Gauge](
	[GID] [bigint] IDENTITY(1,1) NOT NULL,
	[GNo] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PDate] [datetime] NOT NULL,
	[GType] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[GPurpose] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GLSize] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GHSize] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GMake] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GTolerance] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GSpJob] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GSpOpNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CFreq] [int] NOT NULL,
	[CAlertDys] [int] NOT NULL,
	[CAgency] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ISORcNo] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Rejected] [int] NULL,
	[RejDate] [datetime] NULL,
	[GoNoGoSize] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ItemID] [bigint] NULL
) ON [PRIMARY]

GO
