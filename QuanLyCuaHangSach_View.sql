----------------------------VIEW---------------------
--1.Số đầu sách của từng nhà xuất bản
CREATE VIEW SoLuongSachCacNhaXuatBan
AS
	SELECT TenNXB AS [Tên NXB],COUNT(MaSach) AS [Số đầu sách]
	FROM Sach
	INNER JOIN NhaXuatBan ON Sach.MaNXB = NhaXuatBan.MaNXB
	GROUP BY TenNXB

--2.Số tác phẩm của từng tác giả
CREATE VIEW SoTacPhamTungTacGia
AS
	SELECT DISTINCT TenTG AS [Tên tác giả], COUNT(Sach.MaSach) AS [Số đầu sách]
	FROM Sach
	INNER JOIN Sach_TacGia ON Sach.MaSach = Sach_TacGia.MaSach
	INNER JOIN TacGia ON Sach_TacGia.MaTG = TacGia.MaTG
	GROUP BY TenTG

--3.Thông tin 5 nhân viên làm việc lâu nhất, sắp xếp theo số ngày làm giảm dần
CREATE VIEW NhanVienLauNam
AS
	SELECT TOP 5*
	FROM NhanVien
	ORDER BY DATEDIFF(DAY,NgayVaoLam,GETDATE()) DESC;

--4.Những khách hàng sinh tháng 1
CREATE VIEW KhachHangSinhThang1
AS 
	SELECT *
	FROM KhachHang
	WHERE MONTH(NgaySinh) = 1

--5.Số lượng sách còn lại của các đầu sách
CREATE VIEW SoLuongSachConLai
AS
	SELECT TOP 100 PERCENT S.TenSach,S.SoLuong -ISNULL(SUM(SoLuongMua),0) AS [Số sách còn lại]
	FROM Sach AS S
	LEFT JOIN ChiTietDonMua ON S.MaSach = ChiTietDonMua.MaSach
	GROUP BY S.MaSach,S.TenSach,SoLuong
	ORDER BY S.MaSach ASC

--6.Những khách hàng mua hàng từ 2 lần trở lên
CREATE OR ALTER VIEW KhachHangMua2LanTroLen
AS
	SELECT TenKH AS [Tên khách hàng],KH.MaKH AS [Mã khách hàng],COUNT(TenKH) AS [Số lần mua hàng]
	FROM KhachHang AS KH
	INNER JOIN HoaDonMua ON KH.MaKH = HoaDonMua.MaKH
	GROUP BY TenKH,KH.MaKH
	HAVING COUNT(TenKH) >= 2

--7.Số hóa đơn mua mà mỗi nhân viên đã lập
CREATE OR ALTER VIEW NhanVienLapNhieuHoaDonMuaNhat
AS
	SELECT TOP 100 PERCENT TenNV,NhanVien.MaNV,COUNT(NhanVien.MaNV) AS [Số hóa đơn]
	FROM NhanVien
	INNER JOIN HoaDonMua ON NhanVien.MaNV = HoaDonMua.MaNV
	GROUP BY TenNV,NhanVien.MaNV

--8.Thông tin sách(Tên sách,mã sách,ngày nhập, số ngày tồn) mà chưa có khách hàng mua
CREATE VIEW SachChuaDuocMua
AS
	SELECT TenSach AS[Tên sách],S.MaSach AS[Mã sách],NgayNhap AS[Ngày nhập],DATEDIFF(DAY,NgayNhap,GETDATE()) AS [Số ngày tồn]
	FROM SACH AS S
	INNER JOIN ChiTietDonNhap ON S.MaSach = ChiTietDonNhap.MaSach
	INNER JOIN HoaDonNhap ON S.MaSach = ChiTietDonNhap.MaSach AND ChiTietDonNhap.SoHDNH = HoaDonNhap.SoHDNH
	LEFT JOIN ChiTietDonMua ON S.MaSach = ChiTietDonMua.MaSach
	WHERE ChiTietDonMua.MaSach IS NULL

--9.Thông tin đơn mua hàng trên 200000(số hóa đơn,tên khách hàng,mã khách hàng,thành tiền)
CREATE OR ALTER VIEW DonTren200000
AS
	SELECT TOP 100 PERCENT HoaDonMua.SoHDMua,KH.TenKH ,KH.MaKH, SUM(DonGia*SoLuongMua) AS [Thành tiền]
	FROM KhachHang AS KH
	INNER JOIN HoaDonMua ON KH.MaKH = HoaDonMua.MaKH
	INNER JOIN ChiTietDonMua ON KH.MaKH = HoaDonMua.MaKH AND ChiTietDonMua.SoHDMua = HoaDonMua.SoHDMua
	GROUP BY HoaDonMua.SoHDMua,KH.MaKH,KH.TenKH
	HAVING SUM(DonGia*SoLuongMua) > 200000
	ORDER BY SUM(DonGia*SoLuongMua) DESC;

	
--10.Thông tin 5 sách được nhập về nhiều nhất(Tên sách,tên tác giả,thể loại,số lượng nhập)
CREATE VIEW Top5_SachNhapNhieuNhat
AS
	SELECT TOP 5 TenSach AS [Tên sách],TacGia.TenTG AS [Tác giả],TheLoai AS [Thể Loại],SoLuongNhap AS[Số lượng nhập]
	FROM Sach AS S
	INNER JOIN ChiTietDonNhap ON S.MaSach = ChiTietDonNhap.MaSach
	INNER JOIN Sach_TacGia ON S.MaSach = Sach_TacGia.MaSach
	INNER JOIN TacGia ON Sach_TacGia.MaTG = TacGia.MaTG
	GROUP BY S.TenSach,S.MaSach,TacGia.TenTG,TheLoai,ChiTietDonNhap.SoLuongNhap
