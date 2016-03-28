/****** Cannot script Unresolved Entities : Server[@Name='DESKTOP-QHA6FLQ\SQLEXPRESSADV']/Database[@Name='Auto']/UnresolvedEntity[@Name='Mst_Accounts'] ******/
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_VoucherPrefix](
	[EntryName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Prefix] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Startno] [numeric](18, 0) NULL,
	[Minlength] [int] NOT NULL CONSTRAINT [DF_Mst_VoucherPrefix_Minlength]  DEFAULT (3),
	[CurrentNo] [numeric](18, 0) NOT NULL CONSTRAINT [DF_Mst_VoucherPrefix_CurrentNo]  DEFAULT (0)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_ReportLink](
	[AcId] [bigint] NULL,
	[Report_Name] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ColPos] [float] NULL,
	[Code] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_LedgerLinkRpt](
	[AcId] [bigint] NOT NULL,
	[Report_Name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ColPos] [int] NULL,
	[MinAmt] [money] NULL,
	[Code] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_Journal](
	[JournalID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[JournalNo] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[JournalDate] [datetime] NULL,
	[AcID] [numeric](18, 0) NOT NULL,
	[GrandTotal] [money] NOT NULL,
	[CrDr] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Narration] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TypeOfEntry] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ER1PeriodFrom] [datetime] NULL,
	[ER1PeriodTo] [datetime] NULL
)

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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[trn_Daybook](
	[DBookID] [numeric](18, 0) NOT NULL,
	[Vno] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Vtype] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Debtor] [numeric](18, 0) NULL,
	[Creditor] [numeric](18, 0) NULL,
	[Amount] [money] NULL,
	[VDate] [datetime] NULL,
	[Cash] [money] NULL,
	[OnAccount] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Srno] [int] NULL,
	[DescAcID] [numeric](18, 0) NULL,
	[Per_Age] [bigint] NULL DEFAULT ((0)),
	[Temp_ActualAmt] [money] NULL DEFAULT ((0))
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc SP_AutoExiciseJV @ToDate DateTime As Begin   Begin Tran   Begin Try  Declare @SrNo Int,@SrNo_Cr Int,@SrNo_Dr Int  Declare @Code Varchar(100),@Vno VarChar(100)  Declare @ExcessInput Money,@ExcessUtilized Money, @ExcessOutput Money    Declare @Failed BigInt   Declare @DBookID BigInt   Set @Failed = 0      Declare @Tmp_DebitTable Table (SrNo int Identity (1,1) ,AcId BigInt,OutPutBal Money, Utilized Money,Code Varchar(100),UpdateFlag smallint)  Declare @Tmp_CreditTable Table (SrNo int Identity (1,1) ,AcId BigInt,InputBal Money, Utilized Money,Code Varchar(100),UpdateFlag smallint)  Declare @Tmp_Final Table (SrNo Int Identity, Code VarChar(100),Bal Money)    Declare @TrnJournalEntry Table (SNo BigInt Identity (1,1),SrNo BigInt,AcId BigInt Not Null,DebitAmt Float Default(0),CreditAmt Float Default(0),UpdateFlag Char(1),TmpAutoFlag Char(10))    Insert Into @Tmp_CreditTable(AcId,Code,InputBal,Utilized)  Select M1.AcId,M1.Code,Case When Sum(Q1.Bal) > 0 then Sum(Q1.Bal)  Else 0 End As OpeningBal,0  From   Mst_reportLink M1  Inner Join       (      Select AcID As AAcId,Bal =Case When DrCr='Cr' then Obalance*-1 Else obalance End From Mst_Accounts Union All      Select DR.AcID,Sum(Amount) As Bal From Trn_Daybook_Debit Dr Where VDate <=@ToDate Group by DR.AcID Union All      Select Cr.AcID,Sum(Amount)*-1  As Bal From Trn_Daybook_Credit Cr Where VDate <=@ToDate Group by Cr.AcID      ) Q1      On Q1.AAcId= AcId   Group By AcId, Code,Report_Name,colpos    Having Report_Name = 'FormER01'   Order By ColPos   Insert Into @Tmp_DebitTable (AcId,Code,OutPutBal,Utilized)  Select M1.AcId,M1.Code,Case When Sum(Q1.Bal) < 0 then Abs(Sum(Q1.Bal))  Else 0 End As OpeningBal,0  From    Mst_LedgerLinkRpt M1  Inner Join       (      Select AcID As AAcId,Bal =Case When DrCr='Cr' then Obalance*-1 else obalance end  From Mst_Accounts Union All      Select DR.AcID,Sum(Amount) As Bal From Trn_Daybook_Debit Dr Where VDate <=@ToDate Group by DR.AcID Union All      Select Cr.AcID,Sum(Amount)*-1  As Bal From Trn_Daybook_Credit Cr Where VDate <=@ToDate Group by Cr.AcID      ) Q1      On Q1.AAcId= AcId   Group By AcId, Code,Report_Name,Colpos   Having Report_Name = 'Sales Excise Report' And Len(Code) > 0  Order By ColPos    Update @Tmp_CreditTable Set Code='CENVAT' Where Code in ('SERVICE_TAX' ,'ADC_LVD_CT_75')  Update @Tmp_CreditTable Set Code='EDU_CESS' Where Code in ('EDU_CESS_ST')  Update @Tmp_CreditTable Set Code='SEC_EDU_CESS' Where Code in ('SEC_EDU_CESS_ST')    Update @Tmp_DebitTable Set Code='CENVAT' Where Code in ('SERVICE_TAX' ,'ADC_LVD_CT_75')  Update @Tmp_DebitTable Set Code='EDU_CESS' Where Code in ('EDU_CESS_ST')  Update @Tmp_DebitTable Set Code='SEC_EDU_CESS' Where Code in ('SEC_EDU_CESS_ST')    Update @Tmp_CreditTable Set Utilized=InputBal,UpdateFlag =0  Update @Tmp_DebitTable Set Utilized=OutPutBal,UpdateFlag = 0     Insert into @Tmp_Final (Code,Bal)  Select Q1.Code,SUM(Q1.Bal)   from      (      Select E1.Code,E1.OutputBal as Bal from @Tmp_DebitTable E1 Union all      Select E2.Code,E2.InputBal*-1 as Bal from @Tmp_CreditTable E2       ) Q1  Group by Code      -- if Input is above than output  set @SrNo = null  Select @SrNo = Min(SrNo) from @Tmp_Final Where Bal<0      While not @SrNo is null  begin      Select @Code = Code,@ExcessInput = abs(Bal) from @Tmp_Final Where SrNo = @SrNo       Select @SrNo_Cr = Max(SrNo) from @Tmp_CreditTable Where Code = @Code and UpdateFlag = 0         While not @SrNo_Cr is null and @ExcessInput >0      begin          Select @ExcessUtilized  = Utilized from @Tmp_CreditTable Where SrNo = @SrNo_Cr           if @ExcessUtilized   > @ExcessInput               set @ExcessUtilized  = @ExcessInput           Set @ExcessInput = @ExcessInput - @ExcessUtilized           Update @Tmp_CreditTable Set Utilized = Utilized - @ExcessUtilized,UpdateFlag = 1 Where SrNo = @SrNo_Cr           Set @SrNo_Cr = null          Select @SrNo_Cr = Max(SrNo) from @Tmp_CreditTable Where Code = @Code and UpdateFlag = 0                   end      Delete From @Tmp_Final Where SrNo = @SrNo       Set @SrNo = null      Select @SrNo = Min(SrNo) from @Tmp_Final Where Bal<0  end    --if output is above than input   set @SrNo = null  Select @SrNo = Min(SrNo) from @Tmp_Final Where Bal>0      While not @SrNo is null  begin      Select @Code = Code,@ExcessOutput  = abs(Bal) from @Tmp_Final Where SrNo = @SrNo       Select @SrNo_Dr = Max(SrNo) from @Tmp_DebitTable  Where Code = @Code and UpdateFlag = 0         While not @SrNo_Dr is null and @ExcessOutput > 0      begin          Select @ExcessUtilized  = Utilized from @Tmp_DebitTable Where SrNo = @SrNo_Dr           if @ExcessUtilized  > @ExcessOutput               set @ExcessUtilized  = @ExcessOutput           Set @ExcessOutput = @ExcessOutput  - @ExcessUtilized           Update @Tmp_DebitTable Set Utilized = Utilized - @ExcessUtilized,UpdateFlag = 1 Where SrNo = @SrNo_Dr            Set @SrNo_Dr = null          Select @SrNo_Dr  = Max(SrNo) from @Tmp_DebitTable Where Code = @Code and UpdateFlag = 0                   end      Delete From @Tmp_Final Where SrNo = @SrNo       Set @SrNo = null      Select @SrNo = Min(SrNo) from @Tmp_Final Where Bal>0  end       if (Select SUM(Utilized) from @Tmp_CreditTable) >0  begin           Select @DBookID  = Max(DBookID) + 1  From Trn_DayBook      Select @Vno  = Prefix + REPLICATE('0',Minlength-LEN(CurrentNo+ 1))  + CONVERT(Varchar, CurrentNo+1) From Mst_VoucherPrefix Where EntryName = 'Journal'                Insert Into Trn_Journal (JournalNo,JournalDate,AcID,CrDr,GrandTotal,Narration,TypeOfEntry)      Select @Vno,@Todate,0,'',0,'Input Transfer to Outputs','Credit Utilized For Payment of Duty On Goods'          Insert Into Trn_DayBook(DbookId,Vno,Vtype,Debtor,Creditor,Amount,Vdate,Cash,OnAccount,Description,Srno,DescAcid)      Select @DBookID,@Vno,'Journal',D.AcId,0,Utilized,@ToDate,0,L.AcName,L.AcName,SrNo,0       From     @Tmp_DebitTable D       Inner Join           Mst_Accounts L On D.AcId = L.AcID      Where Utilized  > 0       Union All             Select @DBookID,@Vno,'Journal',0,C.AcId,Utilized,@ToDate,0,L.AcName,L.AcName,SrNo,0       From     @Tmp_CreditTable C       Inner Join Mst_Accounts L On C.AcId = L.AcID      Where Utilized > 0           Insert Into Trn_DayBook_Credit(DBookID,AcID,VDate,Description,VType,VNo,Amount,Narration)       Select @DBookID,C.AcId,@ToDate,'By Journal','Journal',@Vno,C.Utilized,'Input Transfer to Outputs'      From     @Tmp_CreditTable C       Inner Join           Mst_Accounts L On C.AcId = L.AcID       Where Utilized > 0         Insert Into Trn_DayBook_Debit(DBookID,AcID,VDate,Description,VType,VNo,Amount,Narration)       Select @DBookID,d.AcId,@ToDate,'By Journal','Journal',@Vno,D.Utilized,'Input Transfer to Outputs'      From     @Tmp_DebitTable D       Inner Join           Mst_Accounts L On D.AcId = L.AcID       Where Utilized > 0         Update Mst_voucherPrefix set CurrentNo = CurrentNo + 1 Where EntryName = 'Journal'   End  End Try    Begin Catch       Set @Failed=1  End Catch    If @Failed=0      Begin           Commit Tran      End  Else      Rollback Tran         End  
GO
