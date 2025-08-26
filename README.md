Quản lý cửa hàng bán sách
I.Phát biểu bài toán
1.	Mô tả bài toán
Cửa hàng sách Trí Tuệ bán Sách của các Tác giả khác nhau. Cửa hàng nhập các đầu sách từ các Nhà xuất bản để bán cho Khách hàng. Nhân viên của cửa hàng lập Hóa đơn mua cho khách hàng mỗi khi khách đến mua sách và lập Hóa đơn nhập cho cửa hàng mỗi khi nhập sách từ nhà xuất bản. Mỗi hóa đơn đều có các Chi tiết hóa đơn thể hiện rõ giao dịch của cửa hàng với khách hàng và nhà xuất bản.
2.	Các thông tin chi tiết của cửa hàng cần quản lý 
+	Sách có thông tin về mã sách, tên sách, thể loại, mã nhà xuất bản, số lượng hiện có trong cửa hàng và giá bán.  
+	Tác giả có thông tin về mã tác giả và tên tác giả.Vì 1 sách có thể có nhiều tác giả cũng như 1 tác giả có thể viết nhiều sách nên cần thiết cả việc quản lý sách_tác giả gồm mã sách, mã tác giả tương ứng
+	Cửa hàng sẽ lưu lại thông tin của Nhà xuất bản bao gồm mã nhà xuất bản, tên nhà xuất bản, số điện thoại , địa chỉ.
+	Mỗi nhân viên trong cửa hàng có 1 mã nhân viên duy nhất, ngoài ra quản lý thông tin khác như tên nhân viên, giới tính, địa chỉ, số điện thoại, ngày sinh, ngày vào làm, lương,giới tính.
+	Khi nhập sách từ Nhà xuất bản cửa hàng sẽ lập hóa đơn nhập gồm: số hóa đơn nhập , mã nhân viên, mã nhà xuất bản và ngày nhập .
+	Mỗi hóa đơn nhập có các chi tiết hóa đơn chứa thông tin số hóa đơn nhập , mã sách, số lượng nhập và giá nhập.
+	Khách hàng mới khi đến sẽ được cửa hàng lưu lại mã khách hàng, tên khách hàng , địa chỉ và số điện thoại.
+	Khi mua hàng khách hàng sẽ nhận được hóa đơn mua trong đó số hóa đơn là duy nhất, ngoài ra có thông tin về mã nhân viên, mã khách hàng và ngày mua hàng.
+	Mỗi hóa đơn mua sẽ có các chi tiết hóa đơn có thông tin về số hóa đơn, mã sách, số lượng, đơn giá.

II. Mô hình CSDL quan hệ
1.	Mô hình CSDL quan hệ
*TacGia
TT	Tên Trường	Kiểu Dữ Liệu	Ràng Buộc
1	MaTG	varchar(5)	PK
2	TenTG	nvarchar(50)	

*NhaXuatBan
TT	Tên Trường	Kiểu Dữ Liệu	Ràng Buộc
1	MaNXB	varchar(6)	PK
2	TenNXB	nvarchar(50)	
3	                SDT	varchar(12)	
4	                DiaChi	nvarchar(50)	

*KhachHang
TT	Tên Trường	Kiểu Dữ Liệu	Ràng Buộc
1	MaKH	varchar(5)	PK
2	TenKH	nvarchar(50)	
3	SDT	varchar(12)	
4	GioiTinh	nvarchar(6)	
5	NgaySinh	datetime	

*Sach
TT	Tên Trường	Kiểu Dữ Liệu	Ràng Buộc
1	MaSach	varchar(15)	PK
2	TenSach	nvarchar(50)	
3	MaNXB	varchar(15)	FK
4	TheLoai	varchar(15)	
5	SoLuong	float	Số Lượng >= 0
6	GiaBan	float	Giá Bán > 0

*Sach_TacGia
TT	Tên Trường	Kiểu dữ liệu	Ràng Buộc
1	MaSach	varchar(15)	PK,FK
2	MaTG	varchar(5)	PK,FK

*NhanVien
TT	Tên Trường	Kiểu Dữ Liệu	Ràng Buộc
1	MaNV	varchar(15)	PK
2	TenNV	nvarchar(50)	
3	DiaChi	nvarchar(50)	
4	SDT	varchar(12)	
5	NgaySinh	         datetime	
6	NgayVaoLam	         datetime	Độ tuổi từ 18 đến 30
7	Luong	          float	
8	GioiTinh	nvarchar(6)	 ‘Nam’ hoặc ‘Nữ’

*HoaDonNhap
TT	Tên Trường	Kiểu Dữ Liệu	Mô Tả
1	SoHDNH	    Số nguyên tự động tăng	PK
2	MaNV	varchar(15)	FK
3	MaNXB	varchar(15)	FK
4	NgayNhap
	datetime	Ngày nhập hàng  <= ngày hiện tại - 2

*ChiTietHDNhapHang
TT	Tên Trường	Kiểu Dữ Liệu	Mô Tả
1	SoHDNH	int	      PK , FK
2	MaSach	varchar(15)	      PK, FK
3	SoLuongNhap	float	      Số lượng nhập > 0
4	GiaNhap	float	      Giá nhập >0

*HoaDonMua
TT	Tên Trường	Kiểu Dữ Liệu	Mô Tả
1	SoHDMua	int	PK
2	MaNV	varchar(15)	FK
3	MaKH	varchar(15)	FK
4	NgayMua	datetime	
5	MucGiamGia	float	Mặc định mức giảm giá = 0

*ChiTietDonMua
TT	Tên Trường	Kiểu Dữ Liệu	Mô Tả
1	SoHDMua	Int	PK, FK
2	MaSach	varchar(15)	PK, FK
3	DonGia	float	Đơn giá >0
4	SoLuongMua	float	Số lượng mua >0

2.Sơ đồ Diagram
 


III.Tạo bảng CSDL
1.Tạo bảng,ràng buộc
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
--tạo bảng Sach_TacGia
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
2.Nhập dữ liệu
----------NHẬP DỮ LIỆU--------
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
('2022-11-07','NXB005','NV002'),
('2024-03-20','NXB005','NV003');

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
(1,'NV004','KH001','2022-10-12',0),
(2,'NV005','KH002','2022-10-12',0),
(3,'NV006','KH003','2022-11-21',0),
(4,'NV004','KH004','2022-11-21',0),
(5,'NV005','KH005','2023-02-12',0),
(6,'NV007','KH001','2023-02-12',0),
(7,'NV006','KH002','2023-02-17',0),
(8,'NV007','KH004','2023-03-19',0),
(9,'NV008','KH001','2023-07-16',0),
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

IV.Truy vấn dữ liệu
1.Truy vấn dữ liệu từ 1 bảng
--1.Lấy ra số lượng nhân viên
SELECT COUNT(*) AS [Số nhân viên]
FROM NhanVien
 
--2.Lấy ra tên các sách,mã sách,giá bán 
SELECT TenSach,MaSach,GiaBan
FROM Sach
 
--3.Lấy ra thông tin nhân viên(tên nhân viên,giới tính,ngày vào làm) vào làm lâu năm nhất
SELECT TenNV,GioiTinh,NgayVaoLam
FROM NhanVien
GROUP BY TenNV,GioiTinh,NgayVaoLam
HAVING DATEDIFF(DAY,NgayVaoLam,GETDATE())>= (SELECT MAX(DATEDIFF(DAY,NgayVaoLam,GETDATE()))FROM NhanVien)
 
--4.Lấy ra thông tin của khách hàng có mã khách hàng KH007
SELECT *
FROM KhachHang
WHERE MaKH = 'KH007'
 
--5.Lấy ra thông tin toàn bộ sách với tên sách được sắp xếp tăng dần theo bảng chữ cái
SELECT *
FROM Sach
ORDER BY TenSach ASC
 
2.Truy vấn dữ liệu từ nhiều bảng
--6.Lấy số đầu sách của từng nhà xuất bản
	SELECT TenNXB AS [Tên NXB],COUNT(MaSach) AS [Số đầu sách]
	FROM Sach
	INNER JOIN NhaXuatBan ON Sach.MaNXB = NhaXuatBan.MaNXB
	GROUP BY TenNXB
 
--7.Lấy ra số lần mua hàng của từng khách hàng trong năm 2023
	SELECT KhachHang.MaKH,TenKH,COUNT(KhachHang.MaKH) AS [Số lần mua]
	FROM HoaDonMua
	INNER JOIN KhachHang ON HoaDonMua.MaKH = KhachHang.MaKH
	WHERE YEAR(NgayMua) = 2023
	GROUP BY KhachHang.MaKH,TenKH
 

--8.Lấy ra thông tin sách(tên sách,mã sách) chưa được mua lần nào
	SELECT TenSach,Sach.MaSach
	FROM Sach
	LEFT JOIN ChiTietDonMua ON Sach.MaSach = ChiTietDonMua.MaSach
	WHERE ChiTietDonMua.MaSach IS NULL

 

--9.Lấy ra số tác giả của từng sách
	SELECT TenSach,COUNT(MaTG) AS [Số TG]
	FROM Sach
	INNER JOIN Sach_TacGia ON Sach.MaSach = Sach_TacGia.MaSach
	GROUP BY TenSach
 


--10.Lấy ra số hóa đơn,tên khách hàng,mã khách hàng,thành tiền của đơn hàng trên 200000 với thành tiền giảm dần
	SELECT HoaDonMua.SoHDMua AS [Số hóa đơn],KH.TenKH AS [Tên KH],KH.MaKH AS [Mã KH], SUM(DonGia*SoLuongMua) AS [Thành tiền]
	FROM KhachHang AS KH
	INNER JOIN HoaDonMua ON KH.MaKH = HoaDonMua.MaKH
	INNER JOIN ChiTietDonMua ON KH.MaKH = HoaDonMua.MaKH AND ChiTietDonMua.SoHDMua = HoaDonMua.SoHDMua
	GROUP BY HoaDonMua.SoHDMua,KH.MaKH,KH.TenKH
	HAVING SUM(DonGia*SoLuongMua) > 200000
	ORDER BY SUM(DonGia*SoLuongMua) DESC;

 


V.View
1. View số lượng đầu sách của từng nhà xuất bản
CREATE VIEW SoLuongSachCacNhaXuatBan
AS
	SELECT TenNXB AS [Tên NXB],COUNT(MaSach) AS [Số đầu sách]
	FROM Sach
	INNER JOIN NhaXuatBan ON Sach.MaNXB = NhaXuatBan.MaNXB
	GROUP BY TenNXB
 
2.View số tác phẩm của từng tác giả
CREATE VIEW SoTacPhamTungTacGia
AS
	SELECT DISTINCT TenTG AS [Tên tác giả], COUNT(Sach.MaSach) AS [Số đầu sách]
	FROM Sach
	INNER JOIN Sach_TacGia ON Sach.MaSach = Sach_TacGia.MaSach
	INNER JOIN TacGia ON Sach_TacGia.MaTG = TacGia.MaTG
	GROUP BY TenTG
 
3.View thông tin 5 nhân viên làm việc lâu nhất, sắp xếp theo số ngày làm giảm dần
CREATE VIEW NhanVienLauNam
AS
	SELECT TOP 5*
	FROM NhanVien
	ORDER BY DATEDIFF(DAY,NgayVaoLam,GETDATE()) DESC;
 
4.View thông tin khách hàng sinh tháng 1
CREATE VIEW KhachHangSinhThang1
AS 
	SELECT *
	FROM KhachHang
	WHERE MONTH(NgaySinh) = 1
 


 

5.View số lượng sách còn lại của từng đầu sách
CREATE VIEW SoLuongSachConLai
AS
SELECT TOP 100 PERCENT S.TenSach,S.SoLuong -ISNULL(SUM(SoLuongMua),0) AS [Số sách còn lại]
	FROM Sach AS S
	LEFT JOIN ChiTietDonMua ON S.MaSach = ChiTietDonMua.MaSach
	GROUP BY S.MaSach,S.TenSach,SoLuong
	ORDER BY S.MaSach ASC
 


6.View những khách hàng mua 2 lần trở lên
CREATE VIEW KhachHangMua2LanTroLen
AS
SELECT TenKH AS [Tên khách hàng],KH.MaKH AS [Mã khách hàng],COUNT(TenKH) AS [Số lần mua hàng]
	FROM KhachHang AS KH
	INNER JOIN HoaDonMua ON KH.MaKH = HoaDonMua.MaKH
	GROUP BY TenKH,KH.MaKH
	HAVING COUNT(TenKH) >= 2
 

7.View số hóa đơn mua từng nhân viên đã lập
CREATE VIEW NhanVienLapNhieuHoaDonMuaNhat
AS
	SELECT TOP 100 PERCENT TenNV,NhanVien.MaNV,COUNT(NhanVien.MaNV) AS [Số hóa đơn]
	FROM NhanVien
	INNER JOIN HoaDonMua ON NhanVien.MaNV = HoaDonMua.MaNV
	GROUP BY TenNV,NhanVien.MaNV

 
8.View tên sách,mã sách,ngày nhập,số ngày tồn của những sách chưa được mua
CREATE VIEW SachChuaDuocMua
AS
SELECT TenSach AS[Tên sách],S.MaSach AS[Mã sách],NgayNhap AS[Ngày nhập],DATEDIFF(DAY,NgayNhap,GETDATE()) AS [Số ngày tồn]
	FROM SACH AS S
	INNER JOIN ChiTietDonNhap ON S.MaSach = ChiTietDonNhap.MaSach
INNER JOIN HoaDonNhap ON S.MaSach = ChiTietDonNhap.MaSach AND ChiTietDonNhap.SoHDNH = HoaDonNhap.SoHDNH
	LEFT JOIN ChiTietDonMua ON S.MaSach = ChiTietDonMua.MaSach
	WHERE ChiTietDonMua.MaSach IS NULL

  
9.View số hóa đơn,mã khách hàng,tên khách hàng,thành tiền của đơn mua trên 200000
CREATE VIEW DonTren200000
AS
SELECT TOP 100 PERCENT HoaDonMua.SoHDMua,KH.TenKH ,KH.MaKH, SUM(DonGia*SoLuongMua) AS [Thành tiền]
	FROM KhachHang AS KH
	INNER JOIN HoaDonMua ON KH.MaKH = HoaDonMua.MaKH
INNER JOIN ChiTietDonMua ON KH.MaKH = HoaDonMua.MaKH AND ChiTietDonMua.SoHDMua = HoaDonMua.SoHDMua
	GROUP BY HoaDonMua.SoHDMua,KH.MaKH,KH.TenKH
	HAVING SUM(DonGia*SoLuongMua) > 200000
	ORDER BY SUM(DonGia*SoLuongMua) DESC;
 


10.Thông tin 5 sách được nhập về nhiều nhất(Tên sách,tên tác giả,thể loại,số lượng nhập)
CREATE VIEW Top5_SachNhapNhieuNhat
AS
	SELECT TOP 5 TenSach AS [Tên sách],TacGia.TenTG AS [Tác giả],TheLoai AS [Thể Loại],SoLuongNhap AS[Số lượng nhập]
	FROM Sach AS S
	INNER JOIN ChiTietDonNhap ON S.MaSach = ChiTietDonNhap.MaSach
	INNER JOIN Sach_TacGia ON S.MaSach = Sach_TacGia.MaSach
	INNER JOIN TacGia ON Sach_TacGia.MaTG = TacGia.MaTG
	GROUP BY S.TenSach,S.MaSach,TacGia.TenTG,TheLoai,ChiTietDonNhap.SoLuongNhap
 


VI.Store Procedure
1.Cho biết tổng số nhân viên của cửa hàng
CREATE PROC sp_TongSoNhanVien
@sonv INT OUTPUT
AS
	SELECT @sonv = COUNT(MaNV) FROM NhanVien
DECLARE @tongsonv INT
EXEC sp_TongSoNhanVien @sonv = @tongsonv OUTPUT
SELECT @tongsonv AS [Tổng số nhân viên]
 
2.Cho biết số sách nhập vào năm được nhập từ bàn phím
CREATE PROC sp_SoSachNhapNam
@nam int
AS
	SELECT COUNT(MaSach) AS[Số sách nhập ]
	FROM HoaDonNhap
	INNER JOIN ChiTietDonNhap ON HoaDonNhap.SoHDNH = ChiTietDonNhap.SoHDNH
	WHERE YEAR(NgayNhap) = @nam
EXEC sp_SoSachNhapNam @nam = 2022 -–cho biết số sách nhập năm 2022
 
3.Lấy ra số lượng khách hàng trong năm được nhập từ bàn phím
CREATE OR ALTER PROC sp_TongSoKhachHang
@nam int,
@soluongkh int output
AS
	SELECT @soluongkh = COUNT(KhachHang.MaKH)
	FROM KhachHang INNER JOIN HoaDonMua ON KhachHang.MaKH = HoaDonMua.MaKH
	WHERE YEAR(NgayMua) = @nam
DECLARE @tongsokh INT
EXEC sp_TongSoKhachHang @nam = 2022,@soluongkh = @tongsokh OUTPUT –tổng số khách hàng của năm 2022
SELECT @tongsokh AS [Tổng số khách hàng]
 
4.Lấy ra thông tin các sách của nhà xuất bản… được nhập từ bàn phím
CREATE PROC sp_SachCuaNhaXuatBan
@nhaxb nvarchar(30)
AS
	SELECT TenSach,MaSach
	FROM Sach
	INNER JOIN NhaXuatBan ON Sach.MaNXB = NhaXuatBan.MaNXB
	WHERE TenNXB = @nhaxb
EXEC sp_SachCuaNhaXuatBan @nhaxb = N'NXB Trẻ' -–lấy ra các sách của nhà xuất bản Trẻ
 
5.Thêm 1 bản ghi khách hàng
CREATE OR ALTER PROC sp_ThemKhachHangMoi
@makh varchar(5),@tenkh nvarchar(50),@sdt varchar(12),@gioitinh nvarchar(6),@ngaysinh datetime
AS
BEGIN
	IF EXISTS(SELECT * FROM KhachHang WHERE MaKH = @makh)
	PRINT 'Da ton tai khach hang co ma'+@makh
	ELSE
	INSERT INTO KhachHang
	VALUES(@makh,@tenkh,@sdt,@gioitinh,@ngaysinh)
END
EXEC sp_ThemKhachHangMoi @makh = 'KH011',@tenkh = N'Nguyễn Duy Anh',@sdt ='0169335617',@gioitinh = N'Nam',@ngaysinh = '2004-12-20'
--trước khi thực thi
SELECT * FROM KhachHang
 
--sau khi thực thi
SELECT * FROM KhachHang

 
6.Giảm giá bán 20% cho sách của nhà xuất bản nhập từ bàn phím
CREATE OR ALTER PROC sp_GiamGiaSachNXB
@nxb nvarchar(30)
AS
BEGIN
	IF EXISTS(SELECT * FROM NhaXuatBan WHERE TenNXB = @nxb)
	UPDATE Sach
	SET GiaBan = GiaBan * 0.8
	FROM Sach INNER JOIN NhaXuatBan ON Sach.MaNXB = NhaXuatBan.MaNXB
	WHERE TenNXB = @nxb
	ELSE
	PRINT 'Khong tim thay ten nha xuat ban '+@nxb
END
--câu lệnh thực thi
EXEC sp_GiamGiaSachNXB @nxb = N'NXB Kim Đồng'

--trước khi thực thi
SELECT GiaBan FROM Sach INNER JOIN NhaXuatBan ON Sach.MaNXB = NhaXuatBan.MaNXB WHERE TenNXB = N'NXB Kim Đồng'
 

--sau khi thực thi
SELECT GiaBan FROM Sach INNER JOIN NhaXuatBan ON Sach.MaNXB = NhaXuatBan.MaNXB WHERE TenNXB = N'NXB Kim Đồng'

 





7.Lấy ra số lượng sách chưa được mua(từ view SachChuaDuocMua)
CREATE OR ALTER PROC sp_DemSachChuaDuocMua
@soluong int OUTPUT
AS
	SELECT @soluong = COUNT(*) FROM SachChuaDuocMua
DECLARE @sosachchuaduocmua int
EXEC sp_DemSachChuaDuocMua @soluong = @sosachchuaduocmua OUTPUT
SELECT @sosachchuaduocmua AS [Số sách chưa được mua]
 
8.Lấy ra thể loại sách được nhập từ bàn phím
CREATE OR ALTER PROC sp_LayRaTheLoai
@theloai nvarchar(30) OUTPUT,
@tensach nvarchar(30)
AS
	SELECT @theloai = TheLoai
	FROM Sach
	WHERE TenSach = @tensach
DECLARE @tentheloai nvarchar(30)
EXEC sp_LayRaTheLoai @tensach = N'Rùa và thỏ',@theloai = @tentheloai OUTPUT
SELECT @tentheloai AS [Thể loại]
 
9.Xóa chi tiết đơn mua với số hóa đơn nhập từ bàn phím
CREATE OR ALTER PROC sp_XoaChiTietDonMua
@sohd varchar(5)
AS
BEGIN
	IF EXISTS(SELECT * FROM ChiTietDonMua)
	DELETE ChiTietDonMua
	WHERE SoHDMua = @sohd
	ELSE
		PRINT 'Khong ton tai hoa don'+@sohd
END
--câu lệnh thực thi
EXEC sp_XoaChiTietDonMua @sohd = '10'
--trước khi thực thi
SELECT * FROM ChiTietDonMua WHERE SoHDMua = 10
 



--sau khi thực thi
SELECT * FROM ChiTietDonMua WHERE SoHDMua = 10
 
10.Thông tin nhân viên bán được nhiều sách nhất năm nhập từ bàn phím
CREATE OR ALTER PROC NhanVienBanNhieuSach_theo_nam
@nam int
AS
BEGIN
SELECT TOP 1  NhanVien.MaNV as[Mã nhân viên],NhanVien.TenNV as[Tên nhân viên],SUM(ChiTietDonMua.SoLuongMua) as[Số lượng sách đã bán]
	FROM NhanVien ,ChiTietDonMua,HoaDonMua
WHERE YEAR(HoaDonMua.NgayMua) = @nam and ChiTietDonMua.SoHDMua = HoaDonMua.SoHDMua and HoaDonMua.MaNV = NhanVien.MaNV
	GROUP BY NhanVien.MaNV , NhanVien.TenNV
	ORDER BY sum(ChiTietDonMua.SoLuongMua) DESC
END
EXEC NhanVienBanNhieuSach_theo_nam @nam = 2022
 
11.Thêm 1 chi tiết đơn nhập
CREATE OR ALTER PROC sp_ThemChiTietDonNhap
@sohdnhap int,@masach varchar(5),@soluongnhap int,@gianhap float
AS
BEGIN
	IF EXISTS(SELECT * FROM HoaDonNhap WHERE SoHDNH = @sohdnhap)
	BEGIN
		IF (@soluongnhap > 0 AND @gianhap > 0)
		INSERT INTO ChiTietDonNhap
		VALUES(@sohdnhap,@masach,@soluongnhap,@gianhap)
		ELSE
		PRINT 'So luong nhap va gia nhap khong duoc < 0'
	END
	ELSE
		PRINT 'Khong ton tai hoa don nhap tuong ung,moi nhap lai'
END
--câu lệnh thực thi
EXEC sp_ThemChiTietDonNhap @sohdnhap = 6,@masach = 'TT001',@soluongnhap = 50,@gianhap = 150000
--trước khi thực thi
 SELECT * FROM ChiTietDonNhap WHERE SoHDNH = 6
 

--sau khi thực thi
SELECT * FROM ChiTietDonNhap WHERE SoHDNH = 6
 
12.Cập nhật thông tin 1 khách hàng với mã khách hàng,số điện thoại mới nhập từ bàn phím
CREATE OR ALTER PROC sp_CapNhatThongTinKH
@makh varchar(5), @sodtmoi varchar(12)
AS
BEGIN
	IF EXISTS(SELECT * FROM KhachHang WHERE MaKH = @makh)
		UPDATE KhachHang
		SET SDT = @sodtmoi 
		WHERE MaKH = @makh 
	ELSE
		PRINT 'Chua co thong tin khach hang co ma'+@makh
END
--câu lệnh thực thi
EXEC sp_CapNhatThongTinKH @makh = 'KH001',@sodtmoi = '0912266475'
--trước khi thực thi
SELECT * FROM KhachHang WHERE MaKH = 'KH001'
 

--sau khi thực thi
SELECT * FROM KhachHang WHERE MaKH = 'KH001'
 
13.Lấy ra doanh thu(tiền bán - tiền nhập) của sách với tên sách nhập từ bàn phím
CREATE OR ALTER PROC sp_TinhDoanhThuSach
@tensach NVARCHAR(50)
AS
BEGIN
	DECLARE @tiennhaphang FLOAT ,@tienbanhang FLOAT 
	SELECT @tiennhaphang = SUM(GiaNhap*SoLuongNhap)
FROM ChiTietDonNhap INNER JOIN HoaDonNhap ON ChiTietDonNhap.SoHDNH = HoaDonNhap.SoHDNH
	INNER JOIN Sach ON ChiTietDonNhap.MaSach = Sach.MaSach
	WHERE TenSach = @tensach
	SELECT @tienbanhang = SUM(DonGia*SoLuongMua*(1-MucGiamGia))
FROM ChiTietDonMua INNER JOIN HoaDonMua ON ChiTietDonMua.SoHDMua = HoaDonMua.SoHDMua
	INNER JOIN Sach ON ChiTietDonMua.MaSach = Sach.MaSach
	WHERE TenSach = @tensach
	RETURN @tienbanhang - @tiennhaphang -- lấy ra doanh thu 
END
DECLARE @doanhthu float
EXEC @doanhthu = sp_TinhDoanhThuSach @tensach = N'Con cáo và chùm nho'
SELECT @doanhthu AS [Doanh thu]
 
14.Xóa chi tiết đơn mua với mã sách,số hóa đơn nhập từ bàn phím
CREATE OR ALTER PROC sp_XoaChiTietDonMua
@masach varchar(5),@sohdmua int
AS
	DELETE ChiTietDonMua
	WHERE SoHDMua = @sohdmua AND MaSach = @masach
EXEC sp_XoaChiTietDonMua @sohdmua = 1,@masach = 'TT001'--câu lệnh thực thi
--trước khi thực thi
SELECT * FROM ChiTietDonMua WHERE SoHDMua = 1 AND MaSach = 'TT001'
 
--sau khi thực thi
SELECT * FROM ChiTietDonMua WHERE SoHDMua = 1 AND MaSach = 'TT001'
 
15.Sửa giá bán sách với mã sách và giá mới nhập từ bàn phím
CREATE OR ALTER PROC sp_SuaGiaSach
@masach varchar(5),@giamoi float
AS
	IF EXISTS(SELECT * FROM Sach WHERE MaSach = @masach)
	UPDATE Sach
	SET GiaBan = @giamoi
	WHERE MaSach = @masach
EXEC sp_SuaGiaSach @masach = 'TT001',@giamoi = 140000

--trước khi thực thi
SELECT * FROM Sach WHERE MaSach = 'TT001'
 

--sau khi thực thi
SELECT * FROM Sach WHERE MaSach = 'TT001'
 
16.In ra số lượng sách mà khách hàng đã mua với số hóa đơn nhập từ bàn phím 
CREATE OR ALTER PROC sp_SoLuongSachKHMua
@sohd varchar(5),@soluongmua int output
AS
	SELECT @soluongmua = COUNT(MaSach)
	FROM HoaDonMua INNER JOIN ChiTietDonMua ON HoaDonMua.SoHDMua = ChiTietDonMua.SoHDMua
	WHERE HoaDonMua.SoHDMua = @sohd 
DECLARE @sosachmua int
EXEC sp_SoLuongSachKHMua @sohd = 9,@soluongmua = @sosachmua OUTPUT
SELECT @sosachmua AS[Số lượng]
 
17.Thêm 1 chi tiết đơn mua
CREATE OR ALTER PROC sp_ThemChiTietMua
@sohd int,@masach varchar(5),@dongia int ,@soluongmua float
AS
	IF EXISTS(SELECT SoHDMua FROM HoaDonMua WHERE SoHDMua = @sohd)
	IF(@dongia> 0 AND @soluongmua > 0)
	INSERT INTO ChiTietDonMua
	VALUES(@sohd,@masach,@dongia,@soluongmua)
	ELSE 
	PRINT 'Du lieu nhap khong hop le,moi nhap lai'
EXEC sp_ThemChiTietMua @sohd = 3,@masach = 'TT003',@dongia = 75000,@soluongmua = 1 

--trước khi thực thi
SELECT * FROM ChiTietDonMua WHERE SoHDMua = 3
 
--sau khi thực thi
SELECT * FROM ChiTietDonMua WHERE SoHDMua = 3
 
18.Lấy ra thông tin sách được nhiều khách mua nhất của nhà xuất bản có tên được nhập từ bàn phím
CREATE OR ALTER PROC sp_SachBanChay
@nxb nvarchar(30)
AS
	SELECT TOP 1 TenSach AS [Tên sách],Sach.MaSach AS [Mã Sách]
	FROM NhaXuatBan INNER JOIN Sach ON NhaXuatBan.MaNXB = Sach.MaNXB
	INNER JOIN ChiTietDonMua ON Sach.MaSach = ChiTietDonMua.MaSach
	WHERE TenNXB = @nxb
	GROUP BY TenSach,Sach.MaSach
	ORDER BY COUNT(Sach.MaSach) DESC
EXEC sp_SachBanChay @nxb = N'NXB Giáo dục'

 

19.Thêm nhân viên mới
CREATE OR ALTER PROC sp_ThemNhanVienMoi
@manv varchar(5),@tennv nvarchar(50),@diachi nvarchar(30),@sdt varchar(12),@ngaysinh datetime,@ngayvaolam datetime,@gioitinh nvarchar(6),@luong float
AS
	IF EXISTS(SELECT * FROM NhanVien WHERE MaNV = @manv)
	PRINT 'Nhan vien da co trong he thong'
	ELSE
	INSERT INTO NhanVien
	VALUES(@manv,@tennv,@diachi,@sdt,@ngaysinh,@ngayvaolam,@gioitinh,@luong)
EXEC sp_ThemNhanVienMoi @manv = 'NV011',@tennv = N'Nguyễn Trung Hiếu',@diachi = N'HH2A Linh Đàm',@sdt = '01647553394',@ngaysinh = '2002-10-20',@ngayvaolam='2024-03-15',@gioitinh = N'Nam',@luong = 2500000

--trước khi thực thi(chưa có nhân viên có mã NV011)
SELECT * FROM NhanVien WHERE MaNV = 'NV011' 

--sau khi thực thi
SELECT * FROM NhanVien WHERE MaNV = 'NV011'
 
20.Sửa chi tiết nhập hàng
CREATE OR ALTER PROC sp_SuaChiTietNhap
@masach varchar(5),@sohd int,@soluongnhap int,@gianhap float
AS
	IF EXISTS(SELECT * FROM ChiTietDonNhap WHERE MaSach = @masach AND SoHDNH = @sohd)
	BEGIN
		IF(@soluongnhap > 0 AND @gianhap > 0)
			UPDATE ChiTietDonNhap
			SET SoLuongNhap = @soluongnhap ,GiaNhap = @gianhap
			WHERE MaSach = @masach AND @sohd = SoHDNH
		ELSE
		PRINT 'Nhap du lieu khong hop le,moi nhap lai'
	END
	ELSE
		PRINT 'Khong ton tai hoa don nhap tuong ung'

EXEC sp_SuaChiTietNhap @masach = 'TT003',@sohd = 1,@soluongnhap = 10,@gianhap = 65000
--trước khi thực thi
 
--sau khi thực thi
 
 
VII.Trigger
1.Đảm bảo rằng số lượng bán ra <= số lượng sách hiện có
CREATE OR ALTER TRIGGER KiemTraSoLuongBanRa
ON ChiTietDonMua
AFTER INSERT,UPDATE
AS	
	DECLARE @soluongcon int,@soluongmua int, @masach varchar(5)
	SELECT @masach = MaSach FROM inserted
	SELECT @soluongcon = SoLuong FROM Sach
    	SELECT @soluongmua = SoLuongMua FROM inserted
	IF EXISTS(SELECT * FROM Sach WHERE MaSach = @masach)
	BEGIN
		IF @soluongcon < @soluongmua
		BEGIN
        	RAISERROR ('Số lượng hàng không đủ để bán.', 16, 1);
        	ROLLBACK TRANSACTION
		END
		ELSE
		BEGIN
       UPDATE Sach
       SET SoLuong = @soluongcon - @soluongmua
       WHERE MaSach = @masach;
		END
	END
	ELSE
	BEGIN
		PRINT 'Khong ton tai sach'
		ROLLBACK TRAN
	END

ALTER TABLE ChiTietDonMua ENABLE TRIGGER KiemTraSoLuongBanRa
ALTER TABLE ChiTietDonMua DISABLE TRIGGER KiemTraSoLuongBanRa
GO
--kích hoạt
INSERT INTO ChiTietDonMua
VALUES(1,'TT004',100000,25)
 
2.Thêm cột SoDauSach vào bảng HoaDonNhap, cập nhật SoDauSach mỗi lần thêm 1 chi tiết đơn nhập
ALTER TABLE HoaDonNhap
ADD SoDauSach int
UPDATE HoaDonNhap
SET SoDauSach = 0

CREATE OR ALTER TRIGGER KiemTraSoDauSach
ON ChiTietDonNhap
AFTER INSERT,UPDATE
AS
BEGIN
	DECLARE @sohd int,@masach varchar(5),@soluong int
SELECT @sohd = SoHDNH,@masach = MaSach,@soluong = COUNT(MaSach) FROM inserted GROUP BY SoHDNH,MaSach
	IF EXISTS(SELECT * FROM HoaDonNhap WHERE SoHDNH = @sohd)
	UPDATE HoaDonNhap
	SET SoDauSach = ISNULL(SoDauSach,0)+ @soluong
	FROM HoaDonNhap
	INNER JOIN inserted ON HoaDonNhap.SoHDNH = inserted.SoHDNH
	ELSE
	BEGIN
		PRINT 'Khong ton tai so hoa don nhap'
		ROLLBACK TRAN
	END
END
ALTER TABLE ChiTietDonNhap ENABLE TRIGGER KiemTraSoDauSach
ALTER TABLE ChiTietDonNhap DISABLE TRIGGER KiemTraSoDauSach

--kích hoạt trigger
INSERT INTO ChiTietDonNhap
VALUES(6,'TT002',10,120000)
--bảng ChiTietDonNhap
 

--bảng HoaDonNhap
 


3.Thêm cột số đơn hàng vào bảng NhanVien,tự động tăng số hàng bán được khi có hóa đơn mua mới
alter table NhanVien
add SoDonHang int 

update NhanVien
set SoDonHang =0; 
go

create trigger UpdateNhanVien_SoDonHang
on HoaDonMua
for insert
as
begin
	declare @sohd nvarchar(5)
	select @sohd = SoHDMua  from inserted

	update NhanVien
	set SoDonHang = SoDonHang+1
	from NhanVien
	inner join HoaDonMua ON HoaDonMua.MaNV = NhanVien.MaNV
where SoHDMua = @sohd
end
 
alter table HoaDonMua disable trigger UpdateNhanVien_SoDonHang
alter table HoaDonMua enable trigger UpdateNhanVien_SoDonHang
--kích hoạt
insert into HoaDonMua(MaNV,MaKH,NgayMua)
values ('NV001','KH001','2023-01-01')
--bảng HoaDonMua
 



--bảng NhanVien
 
4.Đảm bảo trước khi thêm nhân viên mới vào làm phải có độ tuổi từ 18 đến 30
CREATE TRIGGER KiemTraTuoiNV
ON NhanVien
INSTEAD OF INSERT
AS	
	DECLARE @ngaysinh datetime
	SELECT @ngaysinh = NgaySinh FROM inserted
	IF(YEAR(GETDATE())-YEAR(@ngaysinh) < 18 OR YEAR(GETDATE())-YEAR(@ngaysinh) > 30)
	BEGIN
		PRINT 'Nhan vien vao lam phai tu 18 den 30 tuoi'
		ROLLBACK TRAN
	END

ALTER TABLE NhanVien ENABLE TRIGGER KiemTraTuoiNV
ALTER TABLE NhanVien DISABLE TRIGGER KiemTraTuoiNV
--kích hoạt
INSERT INTO NhanVien(MaNV,TenNV,DiaChi,SDT,NgaySinh,NgayVaoLam,GioiTinh,Luong)
VALUES('NV011',N'Nguyễn Anh Khoa',N'Kim Giang','034786915','1990-12-21','2024-03-20',N'Nam',2000000)
 
5.Không cho sửa mã sách
CREATE TRIGGER UpdateMaSach
ON Sach
INSTEAD OF UPDATE
AS
IF UPDATE(MaSach)
	BEGIN
		PRINT 'Ban khong duoc sua ma sach'
		ROLLBACK TRAN
	END

ALTER TABLE Sach ENABLE TRIGGER UpdateMaSach
ALTER TABLE Sach DISABLE TRIGGER UpdateMaSach
--kích hoạt
UPDATE Sach
SET MaSach = 'TT002'
WHERE MaSach = 'TT001'
 
6.Chỉ cho phép giới tính nhân viên là Nam hoặc Nữ
CREATE TRIGGER CheckGioiTinh
ON NhanVien
AFTER INSERT,UPDATE
AS
BEGIN
	DECLARE @gioitinh nvarchar(6)
	SELECT @gioitinh = GioiTinh FROM inserted
	IF @gioitinh NOT IN(N'Nam',N'Nữ')
	BEGIN
		PRINT 'Khong chap nhan gioi tinh ngoai nam va nu'
		ROLLBACK TRAN
	END
	ELSE
		PRINT 'Sua thanh cong'
END

ALTER TABLE NhanVien ENABLE TRIGGER CheckGioiTinh
ALTER TABLE NhanVien DISABLE TRIGGER CheckGioiTinh
--tắt ràng buộc CK_gioitinh
ALTER TABLE NhanVien NOCHECK CONSTRAINT CK_gioitinh
--sửa giới tính của nhân viên có mã NV001
UPDATE NhanVien
SET GioiTinh = N'Khác' 
WHERE MaNV = 'NV001'
 

7.Thêm cột TongSoHang bảng HoaDonMua,cập nhật TongSoHang mỗi khi thêm ChiTietDonMua
ALTER TABLE HoaDonMua
ADD TongSoHang int
UPDATE HoaDonMua
SET TongSoHang = 0

CREATE TRIGGER UpdateTongSoHang
ON ChiTietDonMua
AFTER INSERT,UPDATE
AS
BEGIN
	DECLARE @Tg TABLE(SoHD int,TongHang int)
	INSERT INTO @Tg(SoHD,TongHang)
	SELECT SoHDMua,COUNT(MaSach)
	FROM inserted
	GROUP BY SoHDMua
	UPDATE HoaDonMua
	SET TongSoHang = TongSoHang + T.TongHang
	FROM HoaDonMua
	INNER JOIN @Tg AS T ON HoaDonMua.SoHDMua = T.SoHD
	WHERE EXISTS(SELECT * FROM inserted WHERE SoHDMua = HoaDonMua.SoHDMua)
END

ALTER TABLE ChiTietDonMua ENABLE TRIGGER UpdateTongSoHang
ALTER TABLE ChiTietDonMua DISABLE TRIGGER UpdateTongSoHang
--Thêm 2 chi tiết đơn mua cho hóa đơn 10
 
INSERT INTO ChiTietDonMua
VALUES
(10,’TT002’,125000,1), 
(10,’TT009’,20000,1); 
 

8.Kiểm tra nhân viên phải vào làm trước khi nhập hàng
CREATE TRIGGER CheckNhanVien_NgayNhapHang
ON HoaDonNhap
AFTER INSERT,UPDATE
AS
	IF EXISTS(
	SELECT inserted.MaNV
	FROM inserted
	INNER JOIN NhanVien ON inserted.MaNV = NhanVien.MaNV
	WHERE inserted.NgayNhap < NhanVien.Ngayvaolam
	)
	BEGIN
		PRINT 'Nhan vien khong duoc lap hoa don vi vao lam sau ngay nhap hang'
		ROLLBACK TRAN
	END
ALTER TABLE HoaDonNhap ENABLE TRIGGER CheckNhanVien_NgayNhapHang
ALTER TABLE HoaDonNhap DISABLE TRIGGER CheckNhanVien_NgayNhapHang
--Trong HoaDonNhap 1 sửa MANV = 'NV003'
 
--bảng HoaDonNhap
 
UPDATE HoaDonNhap
SET MaNV = 'NV003'
WHERE SoHDNH = 1
 
9.Kiểm soát số lượng nhập mỗi sách không quá 50
CREATE TRIGGER CheckSoLuongNhap
ON ChiTietDonNhap
AFTER INSERT,UPDATE
AS
	DECLARE @soluongnhap int
	SELECT @soluongnhap =  SoLuongNhap FROM inserted
	IF @soluongnhap > 50
	BEGIN
		PRINT 'Khong nhap qua 50 sach'
		ROLLBACK TRAN
	END
ALTER TABLE ChiTietDonNhap ENABLE TRIGGER CheckSoLuongNhap
ALTER TABLE ChiTietDonNhap DISABLE TRIGGER CheckSoLuongNhap

--kích hoạt
INSERT INTO ChiTietDonNhap
VALUES(6,'TT003',51,65000)
 
10.Xóa hóa đơn mua thì các chi tiết đơn mua cũng bị xóa theo
CREATE OR ALTER TRIGGER XoaHoaDonMua
ON HoaDonMua
AFTER DELETE
AS
	DECLARE @sohdmua int
	SELECT @sohdmua = SoHDMua FROM deleted
	IF EXISTS(SELECT * FROM ChiTietDonMua WHERE SoHDMua = @sohdmua)
	BEGIN
		DELETE FROM ChiTietDonMua
		WHERE SoHDMua = @sohdmua
	END
	ELSE
		PRINT 'Hoa don mua rong'

ALTER TABLE HoaDonMua ENABLE TRIGGER XoaHoaDonMua
ALTER TABLE HoaDonMua DISABLE TRIGGER XoaHoaDonMua
--xóa hóa đơn mua số 6
SELECT * FROM ChiTietDonMua WHERE SoHDMua = 6
 
DELETE FROM HoaDonMua WHERE SoHDMua = 6
SELECT * FROM ChiTietDonMua WHERE SoHDMua = 6 –-đã xóa 2 chi tiết đơn mua
 

 
VIII.Tạo User và phân quyền
1.Tạo user
CREATE LOGIN thethang1
WITH PASSWORD = '123456', DEFAULT_DATABASE = QuanLyCuaHangSach

CREATE USER thethang1
FROM LOGIN thethang1

CREATE LOGIN thethang2
WITH PASSWORD = '123456', DEFAULT_DATABASE = QuanLyCuaHangSach

CREATE USER thethang2
FROM LOGIN thethang2

CREATE LOGIN hoang1
WITH PASSWORD = '123456', DEFAULT_DATABASE = QuanLyCuaHangSach

CREATE USER hoang1
FOR LOGIN hoang1

CREATE LOGIN hoang2
WITH PASSWORD = '123456', DEFAULT_DATABASE = QuanLyCuaHangSach
CREATE USER hoang2
FOR LOGIN hoang2
2.Phân quyền
--cấp quyền cho user thethang1 quyền xem,thêm,sửa bảng NhanVien
GRANT SELECT,INSERT,UPDATE
ON NhanVien
TO thethang1
--cấp quyền cho user thethang1 xem,thêm dữ liệu bảng Sach

GRANT SELECT,INSERT
ON Sach
TO thethang1
--cấp quyền cho user thethang1 xem,sửa bảng HoaDonMua
GRANT SELECT,UPDATE
ON HoaDonMua
TO thethang1
--cấp quyền cho user thethang2 được xóa dữ liệu bảng Sach
GRANT DELETE
ON Sach
TO thethang2
--cấp quyền cho user thethang2 được thực thi thủ tục sp_GiamGiaSachNXB
GRANT EXEC
ON sp_GiamGiaSachNXB
TO thethang2
--cấp quyền cho user thethang được sửa dữ liệu bảng KhachHang
GRANT UPDATE
ON KhachHang
TO thethang2
--cấp quyền cho user hoang1 được xem,thêm,sửa,xóa dữ liệu bảng HoaDonMua
GRANT SELECT,INSERT,UPDATE,DELETE
ON HoaDonMua
TO hoang1
--cấp quyền user hoang1 được xem,thêm,sửa,xóa dữ liệu bảng ChiTietDonNhap
GRANT SELECT,INSERT,UPDATE,DELETE 
ON ChiTietDonNhap
TO hoang1
--cấp quyền thêm dữ liệu bảng HoaDonNhapcho user hoang1
GRANT INSERT
ON HoaDonNhap
TO hoang1
--cấp quyền thêm dữ liệu bảng Sach cho user hoang2
GRANT INSERT
ON Sach
TO hoang2
--cấp quyền xem,thêm,sửa dữ liệu bảng KhachHang cho user hoang2
GRANT SELECT,INSERT,UPDATE
ON KhachHang
TO hoang2
--cấp quyền xem,sửa view SachChuaDuocMua cho user hoang2
GRANT SELECT,UPDATE
ON SachChuaDuocMua
TO hoang2

3. Thu hồi/cấm sử dụng một số thành phần CSDL
--thu hồi quyền cập nhật mã nhân viên bảng NhanVien của user thethang1
REVOKE UPDATE 
ON NhanVien(MaNV)
FROM thethang1
--thu hồi quyền quyền xóa mã sách,mã NXB bảng Sach của user thethang2
REVOKE DELETE
ON Sach(MaSach,MaNXB)
FROM thethang2


--từ chối quyền thực thi thủ tục sp_GiamGiaSachNXB của user thethang2
DENY EXEC
ON sp_GiamGiaSachNXB
FROM thethang2
--thu hồi quyền xem số điện thoại khách hàng của user hoang2
REVOKE SELECT
ON KhachHang(SDT)
FROM hoang2
--từ chối quyền thêm chi tiết đơn nhập của user hoang1
DENY INSERT
ON ChiTietDonNhap
FROM hoang1
IX. Phân tán
1.Tạo linked server
--tạo linked server có tên Maytram2 với máy có địa chỉ  192.168.22.3,tạo user Thang với password 123456 là remote login 
exec sp_addlinkedserver @server='Maytram2',
						@provider='SQLOLEDB',
						@datasrc ='192.168.22.3,1433',
						@srvproduct='Maytram2'
exec sp_linkedservers –kiểm tra việc tạo linked server
exec sp_addlinkedsrvlogin @rmtsrvname='Maytram2',
							@useself=true,
							@locallogin=null,
							@rmtuser= 'Thang',
							@rmtpassword='123456'
 
--đã tạo linked server thành công
Máy 1 192.168.22.2
Máy 2 192.168.22.3
2.Phân tán ngang
Thực hiện phân tán ngang bảng NhanVien theo giới tính,nhân viên có giới tính là Nam đặt ở máy 1,nhân viên có giới tính nữ đặt ở máy 2
--máy 2
CREATE DATABASE Tram2_QuanLyCuaHangSach
go
USE Tram2_QuanLyCuaHangSach
go
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
--máy 1 
CREATE SYNONYM nvtram2 FOR Maytram2.Tram2_QuanLyCuaHangSach.dbo.NhanVien
--chuyến nhân viên nữ sang trạm 2
INSERT INTO nvtram2
SELECT * FROM NhanVien
WHERE GioiTinh = N'Nữ'

DELETE FROM NhanVien
WHERE GioiTinh = N'Nữ'
Kiểm tra dữ liệu sau phân tán
--máy 1
SELECT * FROM NhanVien
 
--máy 2
SELECT * FROM nvtram2
 
--lấy dữ liệu từ cả 2 máy ghép lại
SELECT * FROM NhanVien
UNION
SELECT * FROM nvtram2
 
3.Phân tán dọc
Thực hiện phân tán dọc bảng HoaDonMua: tạo bảng ThongTinHoaDonMua ở máy 2(SoHDMua,MucGiamGia,TongSoHang,NgayMua),máy 1 bảng HoaDonMua mới gồm (SoHDMua,MaNV,MaKH).
--đặt bí danh
CREATE SYNONYM tthoadon FOR Maytram2.Tram2_QuanLyCuaHangSach.dbo.ThongTinHoaDon
--chuyển dữ liệu sang máy 2
INSERT INTO tthoadon
SELECT SoHDMua,MucGiamGia,TongSoHang,NgayMua
FROM HoaDonMua
--xóa những cột MucGiamGia,TongSoHang ở máy 1
ALTER TABLE HoaDonMua
DROP CONSTRAINT DF_mucgiamgia
ALTER TABLE HoaDonMua
DROP CONSTRAINT CK_NgayMua
ALTER TABLE HoaDonMua
DROP COLUMN MucGiamGia,TongSoHang,NgayMua
--máy 1 SELECT * FROM HoaDonMua
 
--máy 2 SELECT * FROM tthoadon
 
--SELECT * FROM HoaDonMua JOIN tthoadon ON HoaDonMua.SoHDMua = tthoadon.SoHDMua
 
