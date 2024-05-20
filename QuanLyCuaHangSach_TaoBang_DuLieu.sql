-------------TẠO DATABASE, BẢNG---------------------
--tạo database QuanLyCuaHangSach
CREATE DATABASE QuanLyCuaHangSach 
GO
USE QuanLyCuaHangSach
GO
--tạo bảng NhaXuatBan
CREATE TABLE NhaXuatBan
(
	MaNXB varchar(6) not null,
	TenNXB nvarchar(30),
	SDT varchar(12),
	DiaChi nvarchar(30),
	CONSTRAINT PK_manxb PRIMARY KEY(MaNXB)
)
--tạo bảng KhachHang
CREATE TABLE KhachHang
(
	MaKH varchar(5) not null,
	TenKH nvarchar(50),
	SDT varchar(12),
	GioiTinh nvarchar(6),
	NgaySinh datetime,
	CONSTRAINT PK_makh PRIMARY KEY(MaKH)
)
--tạo bảng TacGia
CREATE TABLE TacGia
(
	MaTG varchar(5) not null,
	TenTG nvarchar(50),
	CONSTRAINT PK_matg PRIMARY KEY(MaTG)
)
--

--tạo bảng Sach
CREATE TABLE Sach
(
	MaSach varchar(5) not null,
	TenSach nvarchar(50),
	MaNXB varchar(6) not null,
	TheLoai nvarchar(30),
	SoLuong int,
	GiaBan float,
	CONSTRAINT PK_masach_matg PRIMARY KEY(MaSach),
	CONSTRAINT FK_sach_nxb FOREIGN KEY(MaNXB) REFERENCES NhaXuatBan(MaNXB),
	CONSTRAINT CK_soluong CHECK(SoLuong >= 0),
	CONSTRAINT CK_giaban CHECK(GiaBan > 0)
)
CREATE TABLE Sach_TacGia
(
	MaSach varchar(5) not null,
	MaTG varchar(5) not null,
	CONSTRAINT PK_sach_tg PRIMARY KEY(MaSach,MaTG),
	CONSTRAINT FK_masach FOREIGN KEY(MaSach) REFERENCES Sach(MaSach),
	CONSTRAINT FK_matg FOREIGN KEY(MaTG) REFERENCES TacGia(MaTG)
)
--tạo bảng NhanVien
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
	CONSTRAINT PK_manv PRIMARY KEY(MaNV),
	CONSTRAINT CK_tuoi CHECK(DATEDIFF(DAY,NgaySinh,NgayVaoLam)/365 >= 18 AND DATEDIFF(DAY,NgaySinh,NgayVaoLam)/365 <= 30),
	CONSTRAINT CK_gioitinh CHECK(GioiTinh = N'Nam' OR GioiTinh = N'Nữ')
)
--tạo bảng HoaDonNhap
CREATE TABLE HoaDonNhap
(
	SoHDNH int identity,
	NgayNhap datetime,
	MaNXB varchar(6) not null,
	MaNV varchar(5) not null,
	CONSTRAINT PK_hdnhap PRIMARY KEY(SoHDNH),
	CONSTRAINT FK_hdnhap_nxb FOREIGN KEY(MaNXB) REFERENCES NhaXuatBan(MaNXB),
	CONSTRAINT FK_hdnhap_nv FOREIGN KEY(MaNV) REFERENCES NhanVien(MaNV),
	CONSTRAINT CK_ngaynhap CHECK(NgayNhap <= DATEADD(DAY,-2,GETDATE())) 
)
--taọ bảng ChiTietDonNhap
CREATE TABLE ChiTietDonNhap
(
	SoHDNH int,
	MaSach varchar(5) not null,
	SoLuongNhap int,
	GiaNhap float,
	CONSTRAINT PK_hdnh_masach PRIMARY KEY(SoHDNH,MaSach),
	CONSTRAINT FK_chitietnhap_hdnhap FOREIGN KEY(SoHDNH) REFERENCES HoaDonNhap(SoHDNH),
	CONSTRAINT CK_soluongnhap CHECK(SoLuongNhap > 0),
	CONSTRAINT CK_gianhap CHECK(GiaNhap > 0)
)
ALTER TABLE ChiTietDonNhap
ADD CONSTRAINT FK_chitietdonnhap_masach FOREIGN KEY(MaSach) REFERENCES Sach(MaSach)
--tạo bảng HoaDonMua
CREATE TABLE HoaDonMua
(
	SoHDMua int not null,
	MaNV varchar(5) not null,
	MaKH varchar(5) not null,
	NgayMua datetime,
	MucGiamGia float CONSTRAINT DF_mucgiamgia DEFAULT 0,
	CONSTRAINT PK_hdmua PRIMARY KEY(SoHDMua),
	CONSTRAINT FK_hdmua_nhanvien FOREIGN KEY(MaNV) REFERENCES NhanVien(MaNV),
	CONSTRAINT FK_hdmua_khachhang FOREIGN KEY(MaKH) REFERENCES KhachHang(MaKH),
	CONSTRAINT CK_ngaymua CHECK(DATEDIFF(DAY,NgayMua,GETDATE())/365 >= 0),
)
--tạo bảng ChiTietDonMua
CREATE TABLE ChiTietDonMua
(
	SoHDMua int not null,
	MaSach varchar(5) not null,
	DonGia float,
	SoLuongMua int,
	CONSTRAINT PK_chitiethdmua PRIMARY KEY(SoHDMua,MaSach),
	CONSTRAINT FK_chitiethdmua_sohd FOREIGN KEY(SoHDMua) REFERENCES HoaDonMua(SoHDMua),
	CONSTRAINT FK_chitiethdmua_masach FOREIGN KEY(MaSach) REFERENCES Sach(MaSach),
	CONSTRAINT CK_dongia CHECK(DonGia > 0),
	CONSTRAINT CK_soluongmua CHECK(SoLuongMua > 0)
)

----------NHẬP DỮ LIỆU----------------------------
INSERT INTO TacGia
VALUES
('TG001',N'Nick Vujicic'),
('TG002',N'Andrew Matthew'),
('TG003',N'Phùng Quán'),
('TG004',N'Ngô Tất Tố'),
('TG005',N'Victor Hugo'),
('TG006',N'Thạch Lam'),
('TG007',N'Aesop'),
('TG008',N'Hector Malot'),
('TG009',N'Andersen'),
('TG010',N'Pushkin')


INSERT INTO NhaXuatBan
VALUES
('NXB001',N'NXB Kim Đồng','02439434730',N'Hà Nội'),
('NXB002',N'NXB Trẻ','02437734544',N'TP Hồ Chí Minh'),
('NXB003',N'NXB Giáo Dục','02438221386',N'Hà Nội'),
('NXB004',N'NXB Dân Trí','0104117323',N'Hà Nội'),
('NXB005',N'NXB Văn hóa','0104945204',N'TP Hồ Chí Minh')

INSERT INTO Sach
VALUES
('TT001',N'Cuộc sống không giới hạn','NXB005',N'Tự truyện',20,150000),
('TT002',N'Đời Thay Đổi Khi Chúng Ta Thay Đổi','NXB002',N'Truyện tranh',20,125000),
('TT003',N'Tuổi thơ dữ dội','NXB001',N'Tiểu thuyết',50,75000),
('TT004',N'Tắt đèn','NXB003',N'Tiểu thuyết',50,65000),
('TT005',N'Lều chõng','NXB003',N'Tiểu thuyết',20,45000),
('TT006',N'Những người khốn khổ','NXB001',N'Tiểu thuyết',50,70000),
('TT007',N'Hai đứa trẻ','NXB005',N'Truyện ngắn',25,60000),
('TT008',N'Hà Nội băm sáu phố phường','NXB005',N'Bút kí',20,55000),
('TT009',N'Con cáo và chùm nho','NXB004',N'Ngụ ngôn',20,20000),
('TT010',N'Rùa và thỏ','NXB004',N'Ngụ ngôn',20,25000),
('TT011',N'Không gia đình','NXB004',N'Tiểu thuyết',50,125000),
('TT012',N'Chú vịt con xấu xí','NXB002',N'Truyện cố tích',25,25000),
('TT013',N'Ông lão đánh cá và con cá vàng','NXB003',N'Truyện cổ tích',20,45000),
('TT014',N'Đừng bao giờ từ bỏ khát vọng','NXB005',N'Tự truyện',20,125000),
('TT015',N'Chú lính chì dũng cảm','NXB002',N'Truyện cố tích',20,50000)

INSERT INTO Sach_TacGia
VALUES
('TT001','TG001'),
('TT002','TG002'),
('TT003','TG003'),
('TT004','TG004'),
('TT005','TG004'),
('TT006','TG005'),
('TT007','TG006'),
('TT008','TG006'),
('TT009','TG007'),
('TT010','TG008'),
('TT011','TG008'),
('TT012','TG009'),
('TT013','TG010'),
('TT014','TG001'),
('TT015','TG009');



INSERT INTO NhanVien
VALUES
('NV001',N'Nguyễn Tiến An',N'25 Mai Dịch','0347826927','2002-12-21','2021-04-16',N'Nam',3000000),
('NV002',N'Vũ Thị Ngọc Ánh',N'90 Pháo Đài Láng','0341234568','2000-02-11','2021-04-16',N'Nữ',3000000),
('NV003',N'Ngô Hoàng Việt',N'94 Lê Trọng Tấn','0347126977','1995-10-19','2022-03-24',N'Nam',2500000),
('NV004',N'Nguyễn Minh Phú',N'87 Lê Văn Lương','0976342889','2000-09-11','2022-04-16',N'Nam',2500000),
('NV005',N'Nguyễn Đức Tuấn',N'30 Nguyễn Ngọc Nại','0247826925','2003-12-21','2022-04-16',N'Nam',2500000),
('NV006',N'Nguyễn Kỳ Duyên',N'93 Hoàng Văn Thái','0247623747','1994-12-21','2022-06-26',N'Nữ',2500000),
('NV007',N'Nguyễn Mạnh Hùng',N'84 Vũ Phạm Hàm','0246622789','1997-12-21','2022-07-16',N'Nam',2000000),
('NV008',N'Nguyễn Hương Lan',N'250 Nguyễn Khang','0347034512','2002-09-02','2022-07-16',N'Nữ',2000000),
('NV009',N'Lưu Đức Trường',N'77 Khuất Duy Tiến','0247826927','1996-08-15','2023-06-15',N'Nam',2000000),
('NV010',N'Lê Thanh Bình',N'99 Trần Hòa','0352321966','2003-04-10','2023-08-01',N'Nam',2000000)


INSERT INTO KhachHang
VALUES
('KH001',N'Trần Thu Quỳnh','0944401540',N'Nữ','2004-12-20'),
('KH002',N'Trần Quý Dương','0162339864',N'Nam','1982-10-11'),
('KH003',N'Nguyễn Thành Đạt','0347718269',N'Nam','1995-04-17'),
('KH004',N'Lương Minh Trang','0346657492',N'Nữ','1976-08-30'),
('KH005',N'Đào Bình Minh','0393884136',N'Nam','2000-11-26'),
('KH006',N'Phùng Tuấn Sơn','0392884127',N'Nam','1986-01-24'),
('KH007',N'Bùi Thu Nga','0163394652',N'Nữ','2004-05-26'),
('KH008',N'Nguyễn Anh Khoa','0178596331',N'Nam','2001-01-21'),
('KH009',N'Nguyễn Thị Thơ','0974301542',N'Nữ','1999-01-11'),
('KH010',N'Lưu Phương Thảo','0912716378',N'Nữ','2004-11-20')


INSERT INTO HoaDonNhap(NgayNhap,MaNXB,MaNV)
VALUES
('2021-05-20','NXB001','NV001'),
('2021-10-27','NXB002','NV002'),
('2022-01-15','NXB003','NV001'),
('2022-06-16','NXB004','NV003'),
('2022-11-07','NXB005','NV002')

INSERT INTO ChiTietDonNhap
VALUES
(1,'TT003',20,70000),
(1,'TT006',20,65000),
(2,'TT002',10,120000),
(2,'TT012',10,22500),
(2,'TT015',10,45000),
(3,'TT004',20,60000),
(3,'TT005',20,45000),
(3,'TT013',20,45000),
(4,'TT009',20,20000),
(4,'TT010',20,22500),
(4,'TT011',10,120000),
(5,'TT001',10,150000),
(5,'TT007',10,55000),
(5,'TT008',10,55000),
(5,'TT014',10,120000)

INSERT INTO HoaDonMua
VALUES
(1,'NV001','KH001','2022-10-12',0),
(2,'NV003','KH002','2022-10-12',0),
(3,'NV004','KH003','2022-11-21',0),
(4,'NV004','KH004','2022-11-21',0),
(5,'NV005','KH005','2023-02-12',0),
(6,'NV007','KH001','2023-02-12',0),
(7,'NV004','KH002','2023-02-17',0),
(8,'NV007','KH004','2023-03-19',0),
(9,'NV005','KH001','2023-07-16',0),
(10,'NV009','KH003','2023-10-18',0)

INSERT INTO ChiTietDonMua
VALUES
(1,'TT001',150000,1),
(1,'TT002',125000,1),
(1,'TT009',20000,1),
(1,'TT015',50000,1),
(2,'TT003',75000,1),
(2,'TT004',65000,1),
(2,'TT007',60000,2),
(3,'TT012',25000,2),
(4,'TT010',25000,2),
(4,'TT014',125000,1),
(5,'TT006',70000,1),
(6,'TT003',75000,1),
(6,'TT013',45000,1),
(7,'TT002',125000,2),
(8,'TT015',50000,3),
(9,'TT010',25000,2),
(9,'TT003',75000,1),
(10,'TT001',15000,1)

