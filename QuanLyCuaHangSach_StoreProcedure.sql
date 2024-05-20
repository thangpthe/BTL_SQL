--Store Procedure
--1.Lấy ra tổng số nhân viên của cửa hàng
CREATE PROC sp_TongSoNhanVien
@sonv INT OUTPUT
AS
	SELECT @sonv = COUNT(MaNV) FROM NhanVien
DECLARE @tongsonv INT
EXEC sp_TongSoNhanVien @sonv = @tongsonv OUTPUT
SELECT @tongsonv AS [Tổng số nhân viên]

--2.Lấy ra số đầu sách nhập vào năm nhập từ bàn phím
CREATE PROC sp_SoSachNhapNam
@nam int
AS
	SELECT COUNT(MaSach) AS[Số sách nhập ]
	FROM HoaDonNhap
	INNER JOIN ChiTietDonNhap ON HoaDonNhap.SoHDNH = ChiTietDonNhap.SoHDNH
	WHERE YEAR(NgayNhap) = @nam
EXEC sp_SoSachNhapNam @nam = 2022

--3.Lấy ra số lượng khách hàng trong năm nhập từ bàn phím
CREATE OR ALTER PROC sp_TongSoKhachHang
@nam int,
@soluongkh int output
AS
	SELECT @soluongkh = COUNT(KhachHang.MaKH)
	FROM KhachHang INNER JOIN HoaDonMua ON KhachHang.MaKH = HoaDonMua.MaKH
	WHERE YEAR(NgayMua) = @nam
DECLARE @tongsokh INT
EXEC sp_TongSoKhachHang @nam = 2022,@soluongkh = @tongsokh OUTPUT
SELECT @tongsokh AS [Tổng số khách hàng]

--4.Lấy ra thông tin các sách của nhà xuất bản nhập từ bàn phím
CREATE OR ALTER PROC sp_SachCuaNhaXuatBan
@nhaxb nvarchar(30)
AS
	SELECT TenSach,MaSach
	FROM Sach
	INNER JOIN NhaXuatBan ON Sach.MaNXB = NhaXuatBan.MaNXB
	WHERE TenNXB = @nhaxb
EXEC sp_SachCuaNhaXuatBan @nhaxb = N'NXB Trẻ'

--5.Thêm 1 bản ghi khách hàng(chưa thực thi)
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
SELECT * FROM KhachHang
EXEC sp_ThemKhachHangMoi @makh = 'KH011',@tenkh = N'Nguyễn Duy Anh',@sdt ='0169335617',@gioitinh = N'Nam',@ngaysinh = '2004-12-20'
SELECT * FROM KhachHang

--6.Thực hiện giảm giá bán 20% cho sách của nhà xuất bản nhập từ bàn phím
CREATE OR ALTER PROC sp_GiamGiaSachNXB
@nxb nvarchar(30)
AS
	IF EXISTS(SELECT * FROM NhaXuatBan WHERE TenNXB = @nxb)
	BEGIN
	UPDATE Sach
	SET GiaBan = GiaBan * 0.8
	FROM Sach INNER JOIN NhaXuatBan ON Sach.MaNXB = NhaXuatBan.MaNXB
	WHERE TenNXB = @nxb
	END
	ELSE
	BEGIN
	PRINT 'Khong tim thay ten nha xuat ban '+@nxb
	END
--trước khi thực thi
SELECT GiaBan FROM Sach INNER JOIN NhaXuatBan ON Sach.MaNXB = NhaXuatBan.MaNXB WHERE TenNXB = N'NXB Kim Đồng'
EXEC sp_GiamGiaSachNXB @nxb = N'NXB Kim Đồng'
SELECT GiaBan FROM Sach INNER JOIN NhaXuatBan ON Sach.MaNXB = NhaXuatBan.MaNXB WHERE TenNXB = N'NXB Kim Đồng'
--7.Lấy ra số lượng sách chưa được mua(từ view SachChuaDuocMua)
CREATE OR ALTER PROC sp_DemSachChuaDuocMua
@soluong int OUTPUT
AS
	SELECT @soluong = COUNT(*) FROM SachChuaDuocMua
DECLARE @sosachchuaduocmua int
EXEC sp_DemSachChuaDuocMua @soluong = @sosachchuaduocmua OUTPUT
SELECT @sosachchuaduocmua AS [Số sách chưa được mua]

--8.Lấy ra thể loại của sách được nhập từ bàn phím
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
 
--9.Xóa chi tiết đơn mua với số hóa đơn nhập từ bàn phím
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
SELECT * FROM ChiTietDonMua WHERE SoHDMua = 10
EXEC sp_XoaChiTietDonMua @sohd = '10'
SELECT * FROM ChiTietDonMua WHERE SoHDMua = 10

--10.Thông tin nhân viên bán được nhiều sách nhất theo năm nhập từ bàn phím
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
-- thực thi proc NhanVienBanNhieuSach_theo_nam
EXEC NhanVienBanNhieuSach_theo_nam 2022

--11.Thêm 1 chi tiết đơn nhập(chưa thực thi)
CREATE OR ALTER PROC sp_ThemChiTietDonNhap
@sohdnhap int,@masach varchar(5),@soluongnhap int,@gianhap float
AS
BEGIN
	IF EXISTS(SELECT * FROM HoaDonNhap WHERE SoHDNH = @sohdnhap )
		IF @soluongnhap > 0 AND @gianhap > 0
		INSERT INTO ChiTietDonNhap
		VALUES(@sohdnhap,@masach,@soluongnhap,@gianhap)
		ELSE
			PRINT 'So luong nhap va gia nhap khong duoc < 0'
END
SELECT * FROM ChiTietDonNhap WHERE SoHDNH = 6
EXEC sp_ThemChiTietDonNhap @sohdnhap = 6,@masach = 'TT001',@soluongnhap = 50,@gianhap = 150000

--12.Cập nhật thông tin 1 khách hàng với mã khách hàng,số điện thoại mới nhập từ bàn phím(chưa thực thi)
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
SELECT * FROM KhachHang WHERE MaKH = 'KH001'
EXEC sp_CapNhatThongTinKH @makh = 'KH001',@sodtmoi = '0912266475'

--13.Lấy ra doanh thu(tiền bán - tiền nhập) của sách với tên sách nhập từ bàn phím
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

--14.Xóa chi tiết đơn mua với mã sách,số hóa đơn nhập từ bàn phím
CREATE OR ALTER PROC sp_XoaChiTietDonMua
@masach varchar(5),@sohdmua int
AS
	DELETE ChiTietDonMua
	WHERE SoHDMua = @sohdmua AND MaSach = @masach
EXEC sp_XoaChiTietDonMua @sohdmua = 1,@masach = 'TT001'
SELECT * FROM ChiTietDonMua WHERE SoHDMua = 1 AND MaSach = 'TT001'

--15.Sửa giá bán sách với mã sách và giá mới nhập từ bàn phím
CREATE OR ALTER PROC sp_SuaGiaSach
@masach varchar(5),@giamoi float
AS
	IF EXISTS(SELECT * FROM Sach WHERE MaSach = @masach)
	UPDATE Sach
	SET GiaBan = @giamoi
	WHERE MaSach = @masach
EXEC sp_SuaGiaSach @masach = 'TT001',@giamoi = 140000
SELECT * FROM Sach WHERE MaSach = 'TT001'
--16.In ra số lượng sách mà khách hàng đã mua với số hóa đơn nhập từ bàn phím 
CREATE OR ALTER PROC sp_SoLuongSachKHMua
@sohd varchar(5),@soluongmua int output
AS
	SELECT @soluongmua = COUNT(MaSach)
	FROM HoaDonMua INNER JOIN ChiTietDonMua ON HoaDonMua.SoHDMua = ChiTietDonMua.SoHDMua
	WHERE HoaDonMua.SoHDMua = @sohd 
DECLARE @sosachmua int
EXEC sp_SoLuongSachKHMua @sohd = 9,@soluongmua = @sosachmua OUTPUT
SELECT @sosachmua AS[Số lượng]

--17.Thêm 1 chi tiết đơn mua(chưa thực thi)
CREATE OR ALTER PROC sp_ThemChiTietMua
@sohd int,@masach varchar(5),@dongia int ,@soluongmua float
AS
	IF EXISTS(SELECT SoHDMua FROM HoaDonMua WHERE SoHDMua = @sohd)
	IF(@dongia> 0 AND @soluongmua > 0)
	INSERT INTO ChiTietDonMua
	VALUES(@sohd,@masach,@dongia,@soluongmua)
	ELSE 
	PRINT 'Du lieu nhap khong hop le,moi nhap lai'
SELECT * FROM ChiTietDonMua WHERE SoHDMua = 3
EXEC sp_ThemChiTietMua @sohd = 3,@masach = 'TT003',@dongia = 75000,@soluongmua = 1

--18.Lấy ra thông tin sách được nhiều khách mua nhất của nhà xuất bản có tên được nhập từ bàn phím
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

--19.Thêm 1 nhân viên mới(chưa thực thi)
CREATE OR ALTER PROC sp_ThemNhanVienMoi
@manv varchar(5),@tennv nvarchar(50),@diachi nvarchar(30),@sdt varchar(12),@ngaysinh datetime,@ngayvaolam datetime,@gioitinh nvarchar(6),@luong float
AS
	IF EXISTS(SELECT * FROM NhanVien WHERE MaNV = @manv)
	PRINT 'Nhan vien da co trong he thong'
	ELSE
	INSERT INTO NhanVien
	VALUES(@manv,@tennv,@diachi,@sdt,@ngaysinh,@ngayvaolam,@gioitinh,@luong)
SELECT * FROM NhanVien WHERE MaNV = 'NV011'
EXEC sp_ThemNhanVienMoi @manv = 'NV011',@tennv = N'Nguyễn Trung Hiếu',@diachi = N'HH2A Linh Đàm',@sdt = '01647553394',@ngaysinh = '2002-10-20',@ngayvaolam='2024-03-15',@gioitinh = N'Nam',@luong = 2500000

--20.Sửa 1 chi tiết nhập hàng(để lại)
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