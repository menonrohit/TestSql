/****** Cannot script Unresolved Entities : Server[@Name='DESKTOP-QHA6FLQ\SQLEXPRESSADV']/Database[@Name='Auto']/UnresolvedEntity[@Name='Mst_Accounts'] ******/
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 Create Function SF_AccLedgersbeforeDate (@BDate DateTime)  returns @Res Table (AcID BigInt,AcName VarChar(150),Balance Money,DrCr VarChar(10)) as begin  declare @Tmp_Sum Table (AcID BigInt,Amt Money)    Insert into @Tmp_Sum (AcID,Amt)  Select AcID,case When DrCr='Dr' then Obalance else Obalance*-1 end as Amt from Mst_Accounts Union all  Select AcID,Sum(Amount) as Amt from Trn_DayBook_Debit Where VDate < @BDate Group by AcID Union All  Select AcID,Sum(Amount) *- 1 as Amt from Trn_DayBook_Credit Where VDate < @BDate Group by AcID    Insert into @Res (AcID,AcName,Balance,DrCr)  select Q1.AcID,M1.AcName,Abs(Q1.Amt),Case When Q1.Amt > 0 then 'Dr' else 'Cr' end as DrCr  From      (      Select E1.AcID,Sum(Amt) as Amt from @Tmp_Sum E1 Group by E1.AcID      ) Q1  Inner Join      Mst_Accounts M1 on Q1.AcID = M1.AcID     return   end 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_DayBook_Debit](
	[DBookID] [numeric](18, 0) NOT NULL,
	[AcID] [numeric](18, 0) NOT NULL,
	[VDate] [datetime] NOT NULL,
	[Description] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VType] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VNo] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Amount] [money] NOT NULL,
	[Narration] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BankDate] [datetime] NULL,
	[PurchaseRef] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL DEFAULT (''),
	[Per_Age] [bigint] NULL DEFAULT ((0))
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_DayBook_Credit](
	[DBookID] [numeric](18, 0) NOT NULL,
	[AcID] [numeric](18, 0) NOT NULL,
	[VDate] [datetime] NOT NULL,
	[Description] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VType] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VNo] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Amount] [money] NOT NULL,
	[Narration] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BankDate] [datetime] NULL,
	[PurchaseRef] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL DEFAULT (''),
	[Per_Age] [bigint] NULL DEFAULT ((0))
)

GO
