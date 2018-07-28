CREATE TABLE #BASE
(
id int IDENTITY(1,1) PRIMARY KEY,
Tcatalog VARCHAR(500),
Tschema VARCHAR(50),
Tname VARCHAR(1000),
Ttype VARCHAR(100)
)
INSERT INTO #BASE
SELECT TABLE_CATALOG as Tcatalog,TABLE_SCHEMA as Tschema,TABLE_NAME as Tname,TABLE_TYPE as Ttype
FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE like '%base table%'
 
select * from #base
 
 
CREATE TABLE #TAB
(
Tcatalog VARCHAR(1000),
Tschema VARCHAR(1000),
Tname VARCHAR(1000),
Cname VARCHAR(1000),
Oposn INT,
Cdefault VARCHAR(1000),
Isnull VARCHAR(1000),
Dtype VARCHAR(1000),
Cmax INT,
Coctlen INT,
Nprec INT,
Nprecradix INT,
Nscale INT,
Dtprec INT,
Ccatalog VARCHAR(1000),
Cshema VARCHAR(1000),
Cset VARCHAR(1000),
Cocatalog VARCHAR(1000),
Coschema VARCHAR(1000),
Coname VARCHAR(1000),
Dcatalog VARCHAR(1000),
Dschema VARCHAR(1000),
Dname VARCHAR(1000)
)
DECLARE @count INT;
SET @count= 1;
WHILE @count <= (select count(*) from #base)
BEGIN
       INSERT INTO #TAB
       SELECT TABLE_CATALOG as Tcatalog,
       TABLE_SCHEMA as Tschema,
       TABLE_NAME as Tname,
       COLUMN_NAME as Cname,
       ORDINAL_POSITION as Oposn,
       COLUMN_DEFAULT as Cdefault,
       IS_NULLABLE as Inull,
       DATA_TYPE as Dtype,
       CHARACTER_MAXIMUM_LENGTH as Cmax,
       CHARACTER_OCTET_LENGTH as Coctlen,
       NUMERIC_PRECISION as Nprec,
       NUMERIC_PRECISION_RADIX as Nprecradix,
       NUMERIC_SCALE as Nscale,
       DATETIME_PRECISION as Dtprec,
       CHARACTER_SET_CATALOG as Ccatalog,
       CHARACTER_SET_SCHEMA as Cshema,
       CHARACTER_SET_NAME as Cset,
       COLLATION_CATALOG as Cocatalog,
       COLLATION_SCHEMA as Coschema,
       COLLATION_NAME as Coname,
       DOMAIN_CATALOG as Dcatalog,
       DOMAIN_SCHEMA as Dschema,
       DOMAIN_NAME as Dname
       FROM INFORMATION_SCHEMA.COLUMNS
       WHERE TABLE_NAME=(select tname from #base where id=@count)
       ORDER BY ORDINAL_POSITION
   SET @count = @count + 1;
END;
 
PRINT 'Done WHILE LOOP on syed';
GO
 
select * from #tab
