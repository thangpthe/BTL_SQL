CREATE DATABASE Tram2_QuanLyCuaHangSach
go
USE Tram2_QuanLyCuaHangSach
CREATE TABLE NhanVien
(
	MaNV varchar(5) not null,
	TenNV nvarchar(50),
	DiaChi nvarchar(30),
	SDT varchar(12),
	NgaySinh datetime,
	NgayVaoLam datetime,
	GioiTinh nvarchar(6),
	Luong float,
	SoDonHang int,
	CONSTRAINT PK_manv PRIMARY KEY(MaNV),
	CONSTRAINT CK_tuoi CHECK(DATEDIFF(DAY,NgaySinh,NgayVaoLam)/365 >= 18 AND DATEDIFF(DAY,NgaySinh,NgayVaoLam)/365 <= 30),
	CONSTRAINT CK_gioitinh CHECK(GioiTinh = N'Nam' OR GioiTinh = N'Nữ')
)
CREATE TABLE ThongTinHoaDonMua
(
	SoHDMua int not null,
	MucGiamGia float CONSTRAINT DF_mucgiamgia DEFAULT 0,
	TongSoHang int
	CONSTRAINT PK_hdmua PRIMARY KEY(SoHDMua)
)
ALTER TABLE ThongTinHoaDonMua ADD NgayMua datetime