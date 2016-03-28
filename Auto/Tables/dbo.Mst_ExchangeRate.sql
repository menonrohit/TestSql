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
