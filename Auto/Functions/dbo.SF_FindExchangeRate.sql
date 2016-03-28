/****** Cannot script Unresolved Entities : Server[@Name='DESKTOP-QHA6FLQ\SQLEXPRESSADV']/Database[@Name='Auto']/UnresolvedEntity[@Name='Mst_Currency'] ******/
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Function SF_FindExchangeRate(@InvoiceDate DateTime)  Returns @Tmp_Result Table (CurrencyId BigInt,CurrencyName Varchar(50),ExchangeDate DateTime,ExchangeRate Float,SerialNo Varchar(100))  As begin Insert Into @Tmp_Result(Currencyid,CurrencyName,ExchangeDate,ExchangeRate,SerialNo)  Select Distinct C.CurrencyId,C.CurrencyName, A.ExchangeDate As ExchageDate,E.ExchangeRate,SerialNo From Mst_ExchangeRate E  Inner Join Mst_Currency C On E.CurrencyId = C.CurrencyId  Inner Join (Select Max(ExchangeDate) As ExchangeDate,CurrencyId As CCurrencyId From Mst_ExchangeRate  Where ExchangeDate <= @InvoiceDate  Group By CurrencyId ) a On a.CCurrencyId = C.CurrencyId  And E.ExchangeDate = A.ExchangeDate Return End 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mst_ExchangeRate](
	[ExchangeId] [bigint] IDENTITY(1,1) NOT NULL,
	[CurrencyId] [bigint] NOT NULL,
	[ExchangeRate] [float] NOT NULL,
	[ExchangeDate] [datetime] NOT NULL,
	[SerialNo] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
