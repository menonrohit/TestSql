SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc DropConstraints @table_name nvarchar(100), @col_name nvarchar(256)  As Begin  Declare @cmd Nvarchar(2000)  Select @cmd = 'Alter Table Mst_Tax drop constraint ' + d.name  From sys.tables t join    sys.default_constraints d on d.parent_object_id = t.object_id  Join    sys.columns c on c.object_id = t.object_id and c.column_id = d.parent_column_id  Where t.name = @table_name and c.name = @col_name  Execute sp_executesql @cmd    End 
GO
