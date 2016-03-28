SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_EmpAdvance](
	[EntryID] [bigint] IDENTITY(1,1) NOT NULL,
	[EmpID] [bigint] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[Descr] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Advance] [money] NULL,
	[Deduction] [money] NULL,
	[AutoDeduct] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Month_Sal] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Year_Sal] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View Vw_4Advance as Select Distinct A.EmpID,Sum(A.Advance) as Sum_Adv,Sum(A.Deduction) as Sum_Ded from Trn_EmpAdvance A Where A.EntryDate<='04/30/2011' group by A.EmpID 
GO
