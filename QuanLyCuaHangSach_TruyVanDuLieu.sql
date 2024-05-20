--1.Lấy ra số lượng nhân viên
SELECT COUNT(*) AS [Số nhân viên]
FROM NhanVien

--2.Lấy ra tên các sách,mã sách,giá bán 
SELECT TenSach,MaSach,GiaBan
FROM Sach

--3.Lấy ra thông tin nhân viên vào làm lâu năm nhất
SELECT TenNV,GioiTinh,NgayVaoLam
FROM NhanVien
GROUP BY TenNV,GioiTinh,NgayVaoLam
HAVING DATEDIFF(DAY,NgayVaoLam,GETDATE())>= (SELECT MAX(DATEDIFF(DAY,NgayVaoLam,GETDATE()))
FROM NhanVien)

--4.Lấy ra thông tin của khách hàng có mã khách hàng KH007
SELECT *
FROM KhachHang
WHERE MaKH = 'KH007'

--5.Lấy ra thông tin toàn bộ sách với tên sách được sắp xếp tăng dần theo bảng chữ cái
SELECT *
FROM Sach
ORDER BY TenSach ASC


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

--8.Lấy ra thông tin sách chưa được mua lần nào
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