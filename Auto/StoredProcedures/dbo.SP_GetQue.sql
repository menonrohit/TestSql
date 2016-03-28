SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Que_Entry](
	[QueID] [bigint] IDENTITY(1,1) NOT NULL,
	[EntryName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TokenNo] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[QueTime] [datetime] NULL,
UNIQUE NONCLUSTERED 
(
	[EntryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure SP_GetQue @EntryName VarChar(100),@TokenNo VarChar(50) as begin begin Try Insert into Que_Entry (EntryName,TokenNo,QueTime) Values (@EntryName,@TokenNo,getdate() ) Select 'Success' as QStatus end Try begin Catch Select 'Failed' as QStatus  end Catch end --select * from fdfhjhdfjshdfjlsdhjfhsdjfhljdshjhfds
GO
