USE [master]
GO
/****** Object:  Database [DemoVB]    Script Date: 9/30/2020 1:21:50 PM ******/
CREATE DATABASE [DemoVB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DemoVB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.TCSON\MSSQL\DATA\DemoVB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DemoVB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.TCSON\MSSQL\DATA\DemoVB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [DemoVB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DemoVB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DemoVB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DemoVB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DemoVB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DemoVB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DemoVB] SET ARITHABORT OFF 
GO
ALTER DATABASE [DemoVB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DemoVB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DemoVB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DemoVB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DemoVB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DemoVB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DemoVB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DemoVB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DemoVB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DemoVB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DemoVB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DemoVB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DemoVB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DemoVB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DemoVB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DemoVB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DemoVB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DemoVB] SET RECOVERY FULL 
GO
ALTER DATABASE [DemoVB] SET  MULTI_USER 
GO
ALTER DATABASE [DemoVB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DemoVB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DemoVB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DemoVB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DemoVB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DemoVB', N'ON'
GO
ALTER DATABASE [DemoVB] SET QUERY_STORE = OFF
GO
USE [DemoVB]
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_BRY]    Script Date: 9/30/2020 1:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_BRY]()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(id) FROM UserList) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(id, 2)) FROM UserList
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'BRY0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 THEN 'BRY0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
GO
/****** Object:  UserDefinedFunction [dbo].[AUTO_TD]    Script Date: 9/30/2020 1:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[AUTO_TD]()
RETURNS VARCHAR(5)
AS
BEGIN
	DECLARE @ID VARCHAR(5)
	IF (SELECT COUNT(idList) FROM TodoList) = 0
		SET @ID = '0'
	ELSE
		SELECT @ID = MAX(RIGHT(idList, 3)) FROM TodoList
		SELECT @ID = CASE
			WHEN @ID >= 0 and @ID < 9 THEN 'TD00' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 9 and @ID <99 THEN 'TD0' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
			WHEN @ID >= 99 THEN 'TD' + CONVERT(CHAR, CONVERT(INT, @ID) + 1)
		END
	RETURN @ID
END
GO
/****** Object:  Table [dbo].[ROLE]    Script Date: 9/30/2020 1:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROLE](
	[idRole] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](20) NOT NULL,
 CONSTRAINT [PK__ROLE__E5045C54CF8EB8A5] PRIMARY KEY CLUSTERED 
(
	[idRole] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[STATUS]    Script Date: 9/30/2020 1:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[STATUS](
	[idStatus] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK__STATUS__01936F74151D2094] PRIMARY KEY CLUSTERED 
(
	[idStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TodoList]    Script Date: 9/30/2020 1:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TodoList](
	[idList] [char](5) NOT NULL,
	[content] [nvarchar](200) NOT NULL,
	[expiredDate] [date] NULL,
	[deleted] [int] NULL,
	[idUser] [char](5) NULL,
	[idStatus] [int] NULL,
	[position] [int] NOT NULL,
 CONSTRAINT [PK__TodoList__143D7F07ED0AF009] PRIMARY KEY CLUSTERED 
(
	[idList] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserList]    Script Date: 9/30/2020 1:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserList](
	[id] [char](5) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[fullName] [nvarchar](50) NULL,
	[dob] [date] NULL,
	[tel] [varchar](20) NULL,
	[deleted] [int] NULL,
	[idRole] [int] NULL,
 CONSTRAINT [PK__UserList__3213E83FCDEF0892] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[ROLE] ON 

INSERT [dbo].[ROLE] ([idRole], [name]) VALUES (1, N'Admin')
INSERT [dbo].[ROLE] ([idRole], [name]) VALUES (2, N'User')
SET IDENTITY_INSERT [dbo].[ROLE] OFF
GO
SET IDENTITY_INSERT [dbo].[STATUS] ON 

INSERT [dbo].[STATUS] ([idStatus], [name]) VALUES (1, N'Progressing')
INSERT [dbo].[STATUS] ([idStatus], [name]) VALUES (2, N'Done')
INSERT [dbo].[STATUS] ([idStatus], [name]) VALUES (3, N'Canceled')
SET IDENTITY_INSERT [dbo].[STATUS] OFF
GO
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD001', N'di choi', CAST(N'2020-09-18' AS Date), 0, N'BRY01', 1, 3)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD002', N'đi chơi PS4', CAST(N'2020-09-17' AS Date), 0, N'BRY01', 1, 2)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD003', N'làm bài t?p', CAST(N'2020-09-08' AS Date), 0, N'BRY01', 1, 4)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD004', N'Chơi thể thao thể dục', CAST(N'2020-09-03' AS Date), 0, N'BRY01', 1, 5)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD005', N'chơi điện tử thùng', CAST(N'2020-09-24' AS Date), 0, N'BRY01', 1, 1)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD006', N'di choi', CAST(N'2020-09-03' AS Date), 0, N'BRY02', 1, 1)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD007', N'đi chơi PS4', CAST(N'2020-09-15' AS Date), 0, N'BRY02', 1, 3)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD008', N'làm bài tập', CAST(N'2020-09-10' AS Date), 0, N'BRY02', 2, 2)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD009', N'an khuya', CAST(N'2020-09-09' AS Date), 0, N'BRY01', 1, 6)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD010', N'âhsvbdasdasd', CAST(N'2020-09-16' AS Date), 1, N'BRY01', 1, 7)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD011', N'hehehe', CAST(N'2020-09-03' AS Date), 1, N'BRY01', 1, 3)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD012', N'ăn hạt é', CAST(N'2020-09-02' AS Date), 0, N'BRY01', 1, 8)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD013', N'dwdwdw', CAST(N'2020-09-02' AS Date), 0, N'BRY01', 1, 7)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD014', N'vui vẻ k quạu nha', CAST(N'2020-09-10' AS Date), 0, N'BRY01', 1, 9)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD015', N'đi ăn Shushi', CAST(N'2020-09-15' AS Date), 0, N'BRY01', 1, 10)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD016', N'làm bài tập', CAST(N'2020-09-26' AS Date), 0, N'BRY01', 1, 11)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD017', N'Chơi thể thao', CAST(N'2020-09-09' AS Date), 0, N'BRY02', 1, 4)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD018', N'Trẩy hội', CAST(N'2020-09-11' AS Date), 0, N'BRY03', 1, 1)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD019', N'dfasf', CAST(N'2020-09-10' AS Date), 0, N'BRY01', 1, 12)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD020', N'dwddwdwdwdwdddw ', CAST(N'2020-09-16' AS Date), 0, N'BRY01', 1, 13)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD021', N'hôm này là ngày thứ sáu "25" cuối tuần', CAST(N'2020-09-26' AS Date), 0, N'BRY01', 1, 14)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD022', N'Chơi thể thao thể dục', CAST(N'2020-09-09' AS Date), 0, N'BRY01', 1, 15)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD023', N'ăn ốc ', CAST(N'2020-09-11' AS Date), 0, N'BRY01', 1, 16)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD024', N'hello', CAST(N'2020-09-16' AS Date), 0, N'BRY01', 1, 17)
INSERT [dbo].[TodoList] ([idList], [content], [expiredDate], [deleted], [idUser], [idStatus], [position]) VALUES (N'TD025', N'ăn kem', CAST(N'2020-09-08' AS Date), 0, N'BRY01', 1, 18)
GO
INSERT [dbo].[UserList] ([id], [email], [password], [fullName], [dob], [tel], [deleted], [idRole]) VALUES (N'BRY01', N'roonysilver@gmail.com', N'e10adc3949ba59abbe56e057f20f883e', N'JASON CHEN', CAST(N'1991-01-11' AS Date), N'0221245215', 0, 1)
INSERT [dbo].[UserList] ([id], [email], [password], [fullName], [dob], [tel], [deleted], [idRole]) VALUES (N'BRY02', N'tc_son@gmail.com', N'e10adc3949ba59abbe56e057f20f883e', N'Tran Cong Son', CAST(N'1995-08-11' AS Date), N'0122321215', 0, 2)
INSERT [dbo].[UserList] ([id], [email], [password], [fullName], [dob], [tel], [deleted], [idRole]) VALUES (N'BRY03', N'lycu6565@gmail.com', N'e10adc3949ba59abbe56e057f20f883e', N'Son Tran Cong', CAST(N'1995-10-15' AS Date), N'0906332014', 0, 2)
GO
ALTER TABLE [dbo].[TodoList] ADD  CONSTRAINT [DF_TodoList_idList]  DEFAULT ([DBO].[AUTO_TD]()) FOR [idList]
GO
ALTER TABLE [dbo].[TodoList] ADD  CONSTRAINT [DF__TodoList__delete__38996AB5]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[UserList] ADD  CONSTRAINT [DF_UserList_id]  DEFAULT ([DBO].[AUTO_BRY]()) FOR [id]
GO
ALTER TABLE [dbo].[UserList] ADD  CONSTRAINT [DF__UserList__delete__3A81B327]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[TodoList]  WITH CHECK ADD  CONSTRAINT [FK__TodoList__idStat__403A8C7D] FOREIGN KEY([idStatus])
REFERENCES [dbo].[STATUS] ([idStatus])
GO
ALTER TABLE [dbo].[TodoList] CHECK CONSTRAINT [FK__TodoList__idStat__403A8C7D]
GO
ALTER TABLE [dbo].[TodoList]  WITH CHECK ADD  CONSTRAINT [FK__TodoList__idUser__398D8EEE] FOREIGN KEY([idUser])
REFERENCES [dbo].[UserList] ([id])
GO
ALTER TABLE [dbo].[TodoList] CHECK CONSTRAINT [FK__TodoList__idUser__398D8EEE]
GO
ALTER TABLE [dbo].[UserList]  WITH CHECK ADD  CONSTRAINT [FK__UserList__idRole__412EB0B6] FOREIGN KEY([idRole])
REFERENCES [dbo].[ROLE] ([idRole])
GO
ALTER TABLE [dbo].[UserList] CHECK CONSTRAINT [FK__UserList__idRole__412EB0B6]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADD_TODO]    Script Date: 9/30/2020 1:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_ADD_TODO]
@content NVARCHAR(MAX),
@idStatus INT,
@expiredDate DATETIME,
@idUser CHAR(5),
@position INT
AS
BEGIN
	BEGIN TRAN
	DECLARE @maxPosition INT
	DECLARE @countRow INT
	SELECT @maxPosition= MAX(position) FROM TodoList WHERE idUser=@idUser
	SELECT @countRow= COUNT(*)
 FROM TodoList WHERE idUser=@idUser 
	If @countRow=0
		INSERT INTO	TodoList(content, idStatus, expiredDate, idUser, position) VALUES(@content, @idStatus, @expiredDate,@idUser,1)
	ELSE IF @Position >@maxPosition OR @position=-123321
		INSERT INTO	TodoList(content, idStatus, expiredDate, idUser, position) VALUES(@content, @idStatus, @expiredDate,@idUser,@maxPosition+1)
	ELSE IF @position <1
	BEGIN
		UPDATE  TodoList SET position=position+1 WHERE  idUser=@idUser
		INSERT INTO	TodoList(content, idStatus, expiredDate, idUser, position) VALUES(@content, @idStatus, @expiredDate,@idUser,1)
	END
	ELSE IF @position >=1 AND @Position<=@maxPosition
	BEGIN
		UPDATE  TodoList SET position=position+1 WHERE  idUser=@idUser AND position>=@position 
		INSERT INTO	TodoList(content, idStatus, expiredDate, idUser, position) VALUES(@content, @idStatus, @expiredDate,@idUser,@position)
	END
	COMMIT
END
GO
/****** Object:  StoredProcedure [dbo].[SP_CHANGE_PRIORITY]    Script Date: 9/30/2020 1:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_CHANGE_PRIORITY]
@positionOld INT,
@positionNew INT,
@idUser CHAR(5)
AS
BEGIN
	BEGIN TRAN
		DECLARE @idList CHAR(5)
		SELECT @idList=idList FROM TodoList WHERE position=@positionOld AND idUser=@idUser AND deleted != 1
		IF @positionOld > @positionNew
		BEGIN
		UPDATE TodoList SET
				position = position+1
				WHERE position >= @positionNew AND position<@positionOld AND idUser=@idUser AND deleted != 1
		UPDATE TodoList SET position=@positionNew WHERE idList=@idList AND idUser=@idUser AND deleted != 1
		END
		ELSE IF @positionOld < @positionNew
		BEGIN
		UPDATE TodoList SET
				position=position-1
				WHERE position >  @positionOld AND position <= @positionNew AND idUser=@idUser AND deleted!=1
		UPDATE TodoList SET position=@positionNew WHERE idList=@idList AND idUser=@idUser AND deleted!=1
		END
	COMMIT
END
GO
/****** Object:  StoredProcedure [dbo].[SP_DELETE_TODO]    Script Date: 9/30/2020 1:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_DELETE_TODO]
@idList CHAR(5),
@idUser CHAR(5)
AS
BEGIN
	BEGIN TRAN
	UPDATE  TodoList SET deleted=1 WHERE idList = @idList AND idUser=@idUser 
	DECLARE @position INT
	SELECT @position=position FROM TodoList WHERE idList = @idList AND idUser=@idUser
	UPDATE  TodoList SET position=position-1 WHERE position>=@position AND idUser=@idUser
	COMMIT
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_COUNT_RECORD]    Script Date: 9/30/2020 1:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_COUNT_RECORD]
@idUser CHAR(5)
AS
BEGIN
SELECT COUNT(*) AS Count FROM TodoList WHERE idUser=@idUser AND deleted =0
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_TODO]    Script Date: 9/30/2020 1:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_TODO]
@expiredDate AS INT,
@idUser AS CHAR(5),
@PageNumber AS INT,
@PageSize AS INT,
@position AS INT
AS
BEGIN
SELECT * FROM(
SELECT ROW_NUMBER()OVER(Order by (select(0))) as rownum,TodoList.*,STATUS.name FROM TodoList JOIN STATUS ON TodoList.idStatus = STATUS.idStatus WHERE deleted = 0 AND idUser=@idUser
) AS t 
ORDER BY 
(CASE @position WHEN 1 THEN 1 END),
(CASE @position WHEN 2 THEN t.position END) ASC,
(CASE @position WHEN 3 THEN t.position END) DESC,
(CASE @expiredDate WHEN 1 THEN 1 END),
(CASE @expiredDate WHEN 2 THEN t.expiredDate END) DESC,
(CASE @expiredDate WHEN 3 THEN t.expiredDate END) ASC
OFFSET ((@PageNumber - 1) * @PageSize) ROWS
FETCH NEXT @PageSize ROWS ONLY;
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_USER]    Script Date: 9/30/2020 1:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_USER]
AS
BEGIN
SELECT * FROM [UserList] JOIN [ROLE] ON [UserList].idRole = [ROLE].idRole WHERE deleted = 0 AND [UserList].idRole=2
END
GO
/****** Object:  StoredProcedure [dbo].[SP_GET_USERLIST]    Script Date: 9/30/2020 1:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SP_GET_USERLIST]
@email NVARCHAR(50),
@password NVARCHAR(50)
AS
BEGIN
SELECT * FROM UserList JOIN ROLE ON UserList.idRole = ROLE.idRole WHERE email=@email AND password=@password
END
GO
/****** Object:  StoredProcedure [dbo].[SP_UPDATE_TODO]    Script Date: 9/30/2020 1:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[SP_UPDATE_TODO]
@idList AS CHAR(5),
@content AS nText,
@expiredDate AS Date,
@idUser AS CHAR(5),
@idStatus AS INT,
@positionOld INT,
@positionNew INT

AS
BEGIN
BEGIN TRAN
DECLARE @maxPosition INT
SELECT @maxPosition=MAX(position) FROM TodoList WHERE idUser=@idUser 
if @positionOld > @positionNew AND @positionNew >= 1
BEGIN
UPDATE TodoList SET 
				position = position + 1 WHERE position >= @positionNew AND position < @positionOld AND idUser=@idUser
UPDATE TodoList SET position = @positionNew WHERE idList=@idList AND idUser=@idUser
END
ELSE IF @positionOld<@positionNew AND @positionNew<=@maxPosition
if @positionOld < @positionNew
BEGIN
UPDATE TodoList SET 
				position = position - 1 WHERE position > @positionOld AND position <=  @positionNew AND idUser=@idUser
UPDATE TodoList SET position = @positionNew WHERE idList=@idList AND idUser=@idUser
END
ELSE IF @positionNew >@maxPosition OR @positionNew=-123321
BEGIN
UPDATE TodoList SET
		position=position-1
		WHERE position>@positionOld AND idUser=@idUser 
UPDATE TodoList SET position=@maxPosition WHERE idList=@idList AND idUser=@idUser 
END
ELSE IF @positionNew < 1 
BEGIN
UPDATE TodoList SET
		position=position + 1
		WHERE position < @positionOld AND idUser = @idUser 
UPDATE TodoList SET position=1 WHERE idList=@idList AND idUser=@idUser
END
UPDATE TodoList SET
	content=@content,expiredDate=@expiredDate,idStatus=@idStatus WHERE idList=@idList AND idUser=@idUser
	COMMIT
END
GO
USE [master]
GO
ALTER DATABASE [DemoVB] SET  READ_WRITE 
GO
