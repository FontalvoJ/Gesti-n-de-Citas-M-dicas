USE [master]
GO
/****** Object:  Database [DB_GestionCitas]    Script Date: 28/09/2024 0:04:29 ******/
CREATE DATABASE [DB_GestionCitas]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DB_GestionCitas', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DB_GestionCitas.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DB_GestionCitas_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\DB_GestionCitas_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [DB_GestionCitas] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB_GestionCitas].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DB_GestionCitas] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET ARITHABORT OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DB_GestionCitas] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DB_GestionCitas] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DB_GestionCitas] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DB_GestionCitas] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET RECOVERY FULL 
GO
ALTER DATABASE [DB_GestionCitas] SET  MULTI_USER 
GO
ALTER DATABASE [DB_GestionCitas] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DB_GestionCitas] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DB_GestionCitas] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DB_GestionCitas] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DB_GestionCitas] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DB_GestionCitas] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DB_GestionCitas', N'ON'
GO
ALTER DATABASE [DB_GestionCitas] SET QUERY_STORE = ON
GO
ALTER DATABASE [DB_GestionCitas] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DB_GestionCitas]
GO
/****** Object:  Table [dbo].[Citas]    Script Date: 28/09/2024 0:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Citas](
	[id_cita] [int] IDENTITY(1,1) NOT NULL,
	[fecha_cita] [datetime] NOT NULL,
	[lugar] [varchar](100) NULL,
	[id_paciente] [int] NOT NULL,
	[id_medico] [int] NOT NULL,
	[estado_cita] [varchar](10) NOT NULL,
	[receta_generada] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_cita] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personas]    Script Date: 28/09/2024 0:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[telefono] [varchar](15) NULL,
	[tipo_persona] [varchar](8) NOT NULL,
	[correo] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Recetas]    Script Date: 28/09/2024 0:04:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recetas](
	[id_receta] [int] IDENTITY(1,1) NOT NULL,
	[codigo_receta] [varchar](50) NOT NULL,
	[id_paciente] [int] NOT NULL,
	[medicamentos] [text] NOT NULL,
	[estado_receta] [varchar](9) NOT NULL,
	[fecha_creacion] [datetime] NULL,
	[fecha_vencimiento] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_receta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Citas] ON 

INSERT [dbo].[Citas] ([id_cita], [fecha_cita], [lugar], [id_paciente], [id_medico], [estado_cita], [receta_generada]) VALUES (2, CAST(N'2024-09-30T10:00:00.000' AS DateTime), N'Consultorio 101', 2, 1, N'Pendiente', 0)
SET IDENTITY_INSERT [dbo].[Citas] OFF
GO
SET IDENTITY_INSERT [dbo].[Personas] ON 

INSERT [dbo].[Personas] ([id], [nombre], [telefono], [tipo_persona], [correo]) VALUES (1, N'Dr. Juan Pérez', N'5551234567', N'Médico', N'juan.perez@gmail.com')
INSERT [dbo].[Personas] ([id], [nombre], [telefono], [tipo_persona], [correo]) VALUES (2, N'Ana García', N'5559876543', N'Paciente', N'ana.garcia@gmail.com')
INSERT [dbo].[Personas] ([id], [nombre], [telefono], [tipo_persona], [correo]) VALUES (4, N'Jarit Paola', N'00000050', N'Médico', N'jarit.paola@gmail.com')
SET IDENTITY_INSERT [dbo].[Personas] OFF
GO
SET IDENTITY_INSERT [dbo].[Recetas] ON 

INSERT [dbo].[Recetas] ([id_receta], [codigo_receta], [id_paciente], [medicamentos], [estado_receta], [fecha_creacion], [fecha_vencimiento]) VALUES (2, N'RECETA-001', 2, N'Paracetamol 500mg, Ibuprofeno 200mg', N'Activa', CAST(N'2024-09-27T22:37:39.740' AS DateTime), CAST(N'2024-10-15T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Recetas] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Personas__2A586E0B06782886]    Script Date: 28/09/2024 0:04:29 ******/
ALTER TABLE [dbo].[Personas] ADD UNIQUE NONCLUSTERED 
(
	[correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Recetas__F0FE2902673772B0]    Script Date: 28/09/2024 0:04:29 ******/
ALTER TABLE [dbo].[Recetas] ADD UNIQUE NONCLUSTERED 
(
	[codigo_receta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Citas] ADD  DEFAULT ('Pendiente') FOR [estado_cita]
GO
ALTER TABLE [dbo].[Citas] ADD  DEFAULT ((0)) FOR [receta_generada]
GO
ALTER TABLE [dbo].[Recetas] ADD  DEFAULT ('Activa') FOR [estado_receta]
GO
ALTER TABLE [dbo].[Recetas] ADD  DEFAULT (getdate()) FOR [fecha_creacion]
GO
ALTER TABLE [dbo].[Citas]  WITH CHECK ADD FOREIGN KEY([id_medico])
REFERENCES [dbo].[Personas] ([id])
GO
ALTER TABLE [dbo].[Citas]  WITH CHECK ADD FOREIGN KEY([id_paciente])
REFERENCES [dbo].[Personas] ([id])
GO
ALTER TABLE [dbo].[Recetas]  WITH CHECK ADD FOREIGN KEY([id_paciente])
REFERENCES [dbo].[Personas] ([id])
GO
ALTER TABLE [dbo].[Citas]  WITH CHECK ADD CHECK  (([estado_cita]='Finalizada' OR [estado_cita]='En proceso' OR [estado_cita]='Pendiente'))
GO
ALTER TABLE [dbo].[Personas]  WITH CHECK ADD CHECK  (([tipo_persona]='Paciente' OR [tipo_persona]='Médico'))
GO
ALTER TABLE [dbo].[Recetas]  WITH CHECK ADD CHECK  (([estado_receta]='Entregada' OR [estado_receta]='Vencida' OR [estado_receta]='Activa'))
GO
USE [master]
GO
ALTER DATABASE [DB_GestionCitas] SET  READ_WRITE 
GO
