/****** Cannot script Unresolved Entities : Server[@Name='DESKTOP-QHA6FLQ\SQLEXPRESSADV']/Database[@Name='Auto']/UnresolvedEntity[@Name='Mst_Accounts'] ******/
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 Create Function SF_CenvatCreditAvailable(@FromDt DateTime ,@ToDate DateTime)  Returns @Tmp_Result Table (InvId BigInt,BpNo Varchar(100),DetailsOfCredit Varchar(250),CENVAT Float,AED_TTA Float,NCCD Float,ADE_LVD_CL_85 Float,  ADC_LVD_CT_75 Float,EDU_CESS Float,SEC_EDU_CESS Float,SERVICE_TAX Float,EDU_CESS_ST Float,SEC_EDU_CESS_ST Float)  As Begin Declare @Tmp_AllBPEntry Table (AcId BigInt,AssAmount Float,Amount Float,Code Varchar(100),TypeOfPurch Varchar(100),InvId BigInt,BPNo Varchar(100))  Declare @Tmp_GetOpeningBal Table (AcId BigInt,OpeningBal Float ,Code Varchar(100)) Insert Into @Tmp_GetOpeningBal(AcId,OpeningBal,Code)  Select Distinct AcId,Case When Sum(Q1.Bal) > 0 then Sum(Q1.Bal)  Else 0 End As OpeningBal,Code From Mst_ReportLink  Left Outer Join (Select AcID As AAcId,Bal =Case When DrCr='Cr' then Obalance*-1 else obalance end  From Mst_Accounts Union All  Select DR.AcID,Sum(Amount) As Bal From Trn_Daybook_Debit Dr Where VDate <@FromDt Group by DR.AcID Union All  Select Cr.AcID,Sum(Amount)*-1  As Bal From Trn_Daybook_Credit Cr Where VDate < @FromDt Group by Cr.AcID) Q1 On Q1.AAcId= AcId Group By AcId, Code,Report_Name  Having Report_Name = 'FormER01'  Insert Into @Tmp_AllBPEntry(AcId,AssAmount,Amount,Code,TypeOfPurch,InvId,BPNo) Select 0,0,Sum(OpeningBal),Code,' Opening Bal',0,0 From @Tmp_GetOpeningBal Group By Code  Insert Into @Tmp_AllBPEntry(AcId,AssAmount,Amount,Code,TypeOfPurch,InvId,BPNo) Select T.Debtor,PT.Amount, T.Amount,L.Code,Pt.TypeOfPurch,PT.InvID,Pt.BPNo From Trn_Daybook T  Inner Join Mst_ReportLink L on T.Debtor = L.AcId And L.Report_Name = 'FormER01' Inner Join Trn_Purchase PT On PT.BpNo = T.Vno Inner Join Mst_Party P On P.PtyID = PT.PtyID  Where T.Vtype = 'Bill Passing' And Len(P.PtyExcise)>4 And Len(Pt.TypeOfPurch)>0 And Pt.BpDate Between @FromDt And @ToDate  Insert Into @Tmp_AllBPEntry(AcId,AssAmount,Amount,Code,TypeOfPurch,InvId,BPNo) Select T.Debtor,0, T.Amount As Amount,L.Code,'Input Services',J.JournalID,J.JournalNo From Trn_Daybook T  Inner Join Mst_ReportLink L on T.Debtor = L.AcId And L.Report_Name = 'FormER01' Inner Join Trn_Journal J On J.JournalNo = T.Vno Where T.Vtype = 'Journal' And T.VDate Between @FromDt And @ToDate  And J.TypeOfEntry = 'Input Services' Insert Into @Tmp_Result (InvId,BpNo,DetailsOfCredit,CENVAT,AED_TTA,NCCD,ADE_LVD_CL_85,  ADC_LVD_CT_75,EDU_CESS,SEC_EDU_CESS,SERVICE_TAX,EDU_CESS_ST,SEC_EDU_CESS_ST) Select InvId,BPNo,TypeOfPurch,IsNull(CENVAT,0) As CENVAT,IsNull(AED_TTA,0) As AED_TTA,  IsNull(NCCD,0) As NCCD,IsNull(ADE_LVD_CL_85,0) As ADE_LVD_CL_85 ,IsNull(ADC_LVD_CT_75,0) As ADC_LVD_CT_75, IsNull(EDU_CESS,0)As EDU_CESS,IsNull(SEC_EDU_CESS,0) As SEC_EDU_CESS,IsNull(SERVICE_TAX,0) As SERVICE_TAX,  IsNull(EDU_CESS_ST,0) as EDU_CESS_ST,IsNull(SEC_EDU_CESS_ST,0) As SEC_EDU_CESS_ST  From(Select BPNo,InvID,Code,TypeOfPurch,Sum(Amount) As Amount From @Tmp_AllBPEntry Group By BPNo,InvID,Code,TypeOfPurch) p  Pivot(SUM(Amount) For Code In (CENVAT,AED_TTA,NCCD,ADE_LVD_CL_85,ADC_LVD_CT_75, EDU_CESS,SEC_EDU_CESS,SERVICE_TAX,EDU_CESS_ST,SEC_EDU_CESS_ST)) As Pvt Order By BPNo Return End 
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
CREATE TABLE [dbo].[Mst_Party](
	[AcID] [numeric](18, 0) NULL,
	[AcName] [varchar](120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[PtyName] [varchar](70) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyUnit] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyAddress1] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyAddress2] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyAddress3] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyCityID] [int] NULL,
	[PtyStateID] [int] NULL,
	[PtyPin] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyOffPhone] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyFax] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyEmail] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyWeb] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyPlantPhone] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyVAT] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyCST] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyExcise] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyPANno] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ptyPLAno] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyType] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyServiceTax] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyRange] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyDivision] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyCommisionarate] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyCertification] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyNotes] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyOpeningBalance] [money] NULL,
	[DrCr] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyManuType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VendorCode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Used] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Category] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ContPerson] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExpLic0] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExpLic1] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ShortName] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Priority] [int] NULL,
	[TDS] [int] NULL,
	[ScopeSupply] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SelCriteria] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExtControl] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PartyType] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ContryName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
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
CREATE TABLE [dbo].[Trn_Bills_Payble](
	[AcID] [numeric](18, 0) NOT NULL,
	[EntryID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[InvNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[InvDate] [datetime] NOT NULL,
	[InvAmount] [money] NOT NULL,
	[InvFrom] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[InvID] [numeric](18, 0) NOT NULL,
	[DueDays] [int] NULL,
	[Labour] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trn_Purchase](
	[InvID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[BpNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[BpDate] [datetime] NOT NULL,
	[InvDate] [datetime] NOT NULL,
	[InvNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PtyID] [numeric](18, 0) NULL,
	[CoID] [numeric](18, 0) NULL,
	[PoNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PoDate] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AmdNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AmdDate] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Amount] [money] NULL,
	[Discount] [money] NULL,
	[Packing] [money] NULL,
	[PackingPercent] [real] NULL,
	[Total] [money] NULL,
	[Roundoff] [real] NULL,
	[NetAmount] [money] NULL,
	[DayBookID] [numeric](18, 0) NULL,
	[CashCredit] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SalesType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TaxOnAssValue] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AcHeadID] [numeric](18, 0) NULL,
	[Bpassing] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Bpassedby] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IndExcise] [money] NULL,
	[IndCess] [money] NULL,
	[MRQty] [float] NULL,
	[MRRate] [money] NULL,
	[Qty_MR] [float] NULL,
	[Rate_MR] [money] NULL,
	[BillAmount] [money] NULL,
	[GrnsUpto] [varchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DueDays] [numeric](18, 0) NULL,
	[Labour] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IndHSCess] [money] NULL,
	[Narration] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TDSDebitNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IndAddDuty] [money] NULL,
	[GeneratedBy] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ApprovedBy] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TypeOfPurch] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TypeOfDeal] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ReturnFlag] [int] NULL
)

GO
