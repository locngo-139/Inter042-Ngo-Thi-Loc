use furama;
-- cau 2 Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 ký tự.
select * 
from nhanvien
where HoTen like 'H%' or HoTen like 'T%' or HoTen like 'K%';

-- cau 3 Hiển thị thông tin của tất cả khách hàng có độ tuổi từ 18 đến 50 tuổi 
-- và có địa chỉ ở “Đà Nẵng” hoặc “Quảng Trị”.
SELECT * FROM khachhang
WHERE ((YEAR(CURDATE())- YEAR(khachhang.NgaySinh))>=18 AND (YEAR(CURDATE())- YEAR(khachhang.NgaySinh))<=50) 
AND (DiaChi like 'Da Nang' or DiaChi like 'Quang Tri');

SELECT *  
FROM khachhang
WHERE (ROUND(DATEDIFF(CURDATE(), NgaySinh) / 365, 0)<=50 AND (ROUND(DATEDIFF(CURDATE(), NgaySinh) / 365, 0)>=18))
AND (DiaChi like 'Da Nang' or DiaChi like 'Quang Tri') ;
    
    -- cau 4 Đếm xem tương ứng với mỗi khách hàng đã từng đặt phòng bao nhiêu
-- lần. Kết quả hiển thị được sắp xếp tăng dần theo số lần đặt phòng của
-- khách hàng. Chỉ đếm những khách hàng nào có Tên loại khách hàng là “Diamond”.

use furama;

SELECT hopdong.idkhachhang, count(*)as SoLanDatPhong  FROM hopdong
left join khachhang on hopdong.idKhachHang=khachhang.idKhachHang
left join loaikhachhang on khachhang.idLoaiKhachHang=loaikhachhang.idLoaiKhachHang
WHERE loaikhachhang.idLoaiKhachHang="Diamond"
GROUP BY hopdong.idkhachhang 
order by count(*)  ;


-- cau 5
-- Hiển thị IDKhachHang, HoTen, TenLoaiKhach, IDHopDong, TenDichVu, NgayLamHopDong, NgayKetThuc, TongTien (Với
-- TongTien được tính theo công thức như sau: ChiPhiThue + SoLuong*Gia, với SoLuong và Giá là từ bảng DichVuDiKem) cho tất cả
-- các Khách hàng đã từng đặt phỏng. (Những Khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).
use furama;

SELECT idKhachHang,HoTen,TenLoiKhach,idHopDong,TenDichVu,NgayLamHopDong,NgayKetThuc,(ChiPhiThue+SoLuong*Gia )as TongTien
FROM hopdong 
left join khachhang on khachhang.idKhachHang=hopdong.idKhachHang
left join dichvu on dichvu.idDichVu= hopdong.idDichVu
left join dichvudikem on dichvudikem.idDichVuDiKem=hopdong.idDichVuDiKem
WHERE ;