--Phân tán
--Ngang (nhân viên có giới tính nữ thì qua máy ảo,còn lại ở bên máy thật)
--Dọc(HoaDonMua sohd,manv,makh,ThongTinHD sohd,muc giam gia,tong so hang)
exec sp_addlinkedserver @server='Maytram2',
						@provider='SQLOLEDB',
						@datasrc ='192.168.22.3,1433',
						@srvproduct='Maytram2'
exec sp_linkedservers
exec sp_addlinkedsrvlogin @rmtsrvname='Maytram2',
							@useself=true,
							@locallogin=null,
							@rmtuser= 'Thang',
							@rmtpassword='123456'

CREATE SYNONYM nvtram2 FOR Maytram2.Tram2_QuanLyCuaHangSach.dbo.NhanVien
INSERT INTO nvtram2
SELECT * FROM NhanVien
WHERE GioiTinh = N'Nữ'

DELETE FROM NhanVien
WHERE GioiTinh = N'Nữ'
--CL03
CREATE VIEW NhanVienCa2Tram
AS
	SELECT * FROM NhanVien
	UNION
	SELECT * FROM nvtram2


--Phân tán dọc
CREATE SYNONYM tthoadon FOR Maytram2.Tram2_QuanLyCuaHangSach.dbo.ThongTinHoaDon
INSERT INTO tthoadon
SELECT SoHDMua,MucGiamGia,TongSoHang,NgayMua
FROM HoaDonMua
ALTER TABLE HoaDonMua
DROP CONSTRAINT DF_mucgiamgia
ALTER TABLE HoaDonMua
DROP CONSTRAINT CK_NgayMua
ALTER TABLE HoaDonMua
DROP COLUMN MucGiamGia,TongSoHang,NgayMua
--CL03
CREATE VIEW vw_HoaDonMuaDayDu
AS
	SELECT HoaDonMua.SoHDMua,HoaDonMua.MaNV,HoaDonMua.MaKH,tthoadon.MucGiamGia AS[MucGiamGia],tthoadon.TongSoHang AS [TongSoHang],tthoadon.NgayMua AS [NgayMua] 
	FROM HoaDonMua JOIN tthoadon ON HoaDonMua.SoHDMua = tthoadon.SoHDMua


--CL02
--a
	ALTER TABLE Sach
	ADD DoanhThu float CONSTRAINT DF_doanhthu DEFAULT 0
	GO
	UPDATE Sach
	SET DoanhThu = ISNULL(DoanhThu,0) +SUM(ChiTietDonMua.SoLuongMua*ChiTietDonMua.DonGia)
	FROM Sach INNER JOIN ChiTietDonMua ON Sach.MaSach = ChiTietDonMua.MaSach

	CREATE PROC LayThongTinSach
	@doanhthu float
	AS
		SELECT * FROM Sach
		WHERE DoanhThu > @doanhthu

	EXEC  LayThongTinSach @doanhthu = 500000

--b.Tao nguoi dung ThiKT
CREATE LOGIN ThiKT
WITH PASSWORD = '123456',DEFAULT_DATABASE = QuanLyCuaHangSach
CREATE USER ThiKT
FROM LOGIN ThiKT

GRANT INSERT
ON Sach
TO ThiKT

