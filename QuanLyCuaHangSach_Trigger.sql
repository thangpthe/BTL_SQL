--Trigger 
--1.Đảm bảo rằng số lượng bán ra <= số lượng sách hiện có
CREATE OR ALTER TRIGGER KiemTraSoLuongBanRa
ON ChiTietDonMua
AFTER INSERT,UPDATE
AS	
BEGIN
	DECLARE @soluongcon int,@soluongmua int,@masach varchar(5),@sohd int
	SELECT @sohd = SoHDMua,@masach = MaSach,@soluongmua = SoLuongMua FROM inserted GROUP BY SoHDMua,MaSach,SoLuongMua
	SELECT @soluongcon = SoLuong FROM Sach WHERE MaSach = @masach
	IF EXISTS(SELECT * FROM Sach WHERE MaSach = @masach)
	BEGIN
	IF @soluongcon < @soluongmua
		BEGIN
        	RAISERROR ('Số lượng hàng không đủ để bán.', 16, 1);
        	ROLLBACK TRANSACTION
		END
	ELSE
		UPDATE Sach
		SET SoLuong = @soluongcon - @soluongmua
		FROM Sach
		INNER JOIN ChiTietDonMua ON Sach.MaSach = ChiTietDonMua.MaSach
		WHERE Sach.MaSach = @MaSach
	END
END

CREATE OR ALTER TRIGGER Trigger_GiamSoLuongSach
ON ChiTietDonMua
FOR INSERT
AS
BEGIN
    -- Khai báo các biến
    DECLARE @MaSach varchar(5);
    DECLARE @SoLuongMua INT,@SoLuongCon int;
    
    -- Lấy dữ liệu từ bảng inserted
    SELECT @MaSach = MaSach, @SoLuongMua = SoLuongMua
    FROM inserted;
	SELECT @SoLuongCon = SoLuong FROM Sach WHERE MaSach = @masach
    -- Kiểm tra và giảm số lượng sách tương ứng
	IF @SoLuongCon >= @SoLuongMua
    UPDATE Sach
    SET SoLuong = SoLuong - @SoLuongMua
    WHERE MaSach = @MaSach
	ELSE
	ROLLBACK TRAN
END;

ALTER TABLE ChiTietDonMua ENABLE TRIGGER KiemTraSoLuongBanRa
ALTER TABLE ChiTietDonMua DISABLE TRIGGER KiemTraSoLuongBanRa
INSERT INTO ChiTietDonMua
VALUES(1,'TT008',100000,25)
GO


--2.Thêm cột SoDauSach vào bảng HoaDonNhap, cập nhật SoDauSach mỗi lần thêm 1 chi tiết đơn nhập
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
INSERT INTO ChiTietDonNhap
VALUES(6,'TT002',10,120000)



--(dự phòng)2.Thêm cột TongTien vào bảng KhachHang,cập nhật TongTien mỗi lần khách đến mua
ALTER TABLE KhachHang
ADD TongTien float
UPDATE KhachHang
SET TongTien = 0

CREATE OR ALTER TRIGGER tinhTongTien
ON ChiTietDonMua
AFTER INSERT,UPDATE
AS
BEGIN
    DECLARE @Tg TABLE (SoHD int, ThanhTien float);

    INSERT INTO @Tg (SoHD, ThanhTien)
    SELECT SoHDMua, SUM(DonGia * Soluongmua)
    FROM inserted
    GROUP BY SoHDMua;

    UPDATE KhachHang
    SET TongTien = ISNULL(TongTien, 0) + T.ThanhTien
    FROM KhachHang 
    INNER JOIN HoaDonMua ON KhachHang.MaKH = HoaDonMua.MaKH
    INNER JOIN @Tg AS T ON T.SoHD = HoaDonMua.SoHDMua
    WHERE EXISTS (
        SELECT *
        FROM inserted
        WHERE SoHD = HoaDonMua.SoHDMua
    )
END
ALTER TABLE ChiTietDonMua ENABLE TRIGGER tinhTongTien
ALTER TABLE ChiTietDonMua DISABLE TRIGGER tinhTongTien

--3.Thêm cột số đơn hàng vào bảng NhanVien,tự động tăng số hàng bán được khi có hóa đơn mua mới
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
insert into HoaDonMua(SoHDMua,MaNV,MaKH,NgayMua)
values (11,'NV001','KH001','2023-01-01')


alter table HoaDonMua disable trigger UpdateNhanVien_SoDonHang
alter table HoaDonMua enable trigger UpdateNhanVien_SoDonHang



--4.Đảm bảo trước khi thêm nhân viên mới vào làm phải có độ tuổi từ 18 đến 30
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

INSERT INTO NhanVien(MaNV,TenNV,DiaChi,SDT,NgaySinh,NgayVaoLam,GioiTinh,Luong)
VALUES('NV011',N'Nguyễn Anh Khoa',N'Kim Giang','034786915','1990-12-21','2024-03-20',N'Nam',2000000)


--5.Không cho sửa mã sách
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

UPDATE Sach
SET MaSach = 'TT002'
WHERE MaSach = 'TT001'
--6.Chỉ cho phép giới tính nhân viên là 'Nam' hoặc 'Nữ'
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
ALTER TABLE NhanVien NOCHECK CONSTRAINT CK_gioitinh
UPDATE NhanVien
SET GioiTinh = N'Khác' 
WHERE MaNV = 'NV001'
--7.Thêm cột TongSoHang bảng HoaDonMua,cập nhật TongSoHang mỗi khi thêm ChiTietDonMua
ALTER TABLE HoaDonMua
ADD TongSoHang int
UPDATE HoaDonMua
SET TongSoHang = 0

CREATE OR ALTER TRIGGER UpdateTongSoHang
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

--8.Kiểm tra nhân viên phải vào làm trước khi nhập hàng
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
UPDATE HoaDonNhap
SET MaNV = 'NV003'
WHERE SoHDNH = 1
--9.Kiểm soát số lượng nhập mỗi sách không quá 50
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
INSERT INTO ChiTietDonNhap
VALUES(6,'TT003',51,65000)
--10.Xóa hóa đơn mua thì các chi tiết đơn mua cũng bị xóa theo
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
SELECT * FROM ChiTietDonMua WHERE SoHDMua = 6
DELETE FROM HoaDonMua WHERE SoHDMua = 6