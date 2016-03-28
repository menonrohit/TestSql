SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create procedure SP_ChekUsedData @Editid bigint , @StrTableName Varchar(100),@Cnt Bigint Output As Begin Create Table #Tmp_RecordCnt (SrNo Bigint Default(0)) Declare @Tmp_All Table (SrNo Bigint identity ,Table_Name varchar(50) , Field_Name varchar(50),Sql_Query varchar(max))  Declare @IntCnt Bigint Declare @IntRecd Bigint Declare @SqlQuery nvarchar(Max) Insert Into @Tmp_All (Table_Name,Field_Name)    Select TABLE_NAME,COLUMN_NAME From INFORMATION_SCHEMA.COLUMNS Where (COLUMN_NAME = 'Empid' and TABLE_NAME <> @StrTableName  And Table_name In (Select Table_name From INFORMATION_SCHEMA.TABLES Where TABLE_TYPE='BASE TABLE'))  Or COLUMN_NAME Like 'oprtrid' and TABLE_NAME <> @StrTableName and Table_name In (Select Table_name From INFORMATION_SCHEMA.TABLES Where TABLE_TYPE='BASE TABLE')  Update @Tmp_All  Set Sql_Query = a.SqlQuery From ( Select Srno As Srnos ,'Select Count('+ Field_Name + ') As Cnt From ' + Table_Name + ' Where ' + Field_Name + ' = ' + str(@Editid) + ' Union all ' As SqlQuery From @Tmp_All ) a Where srno = a.srnos Update @Tmp_All Set Sql_Query= replace(Sql_Query,'Union all','')  Where SrNo in (Select Max(Srno) From @Tmp_All) Set @SqlQuery = '' Select @SqlQuery = @SqlQuery + a.SqlQuery From (Select Sql_Query SqlQuery From @Tmp_All ) a Set @SqlQuery ='Insert Into #Tmp_RecordCnt (SrNo) Select Sum(a.Cnt) From (' + @SqlQuery  + ') a ' Execute sp_executesql @SqlQuery Select @Cnt= Sum(Srno) From #Tmp_RecordCnt  drop table #Tmp_RecordCnt End 
G--rohit
