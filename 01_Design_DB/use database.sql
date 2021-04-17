use furama;
-- cau 2 Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, “T” hoặc “K” và có tối đa 15 ký tự.
select * 
from nhanvien
where substring_index(HoTen, ' ', -1) like 'H%' or substring_index(HoTen, ' ', -1) like 'T%' 
or substring_index(HoTen, ' ', -1) like 'K%';

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

SELECT khachhang.HoTen, count(hopdong.idKhachHang) as SoLanDatPhong 
FROM hopdong
left join khachhang on hopdong.idKhachHang=khachhang.idKhachHang
left join loaikhachhang on loaikhachhang.idLoaiKhachHang=khachhang.idLoaiKhachHang
WHERE loaikhachhang.TenLoaiKhachHang='Diamond'
GROUP BY count(hopdong.idKhachHang)  
order by   ;

-- select HopDong.IDHopDong,KhachHang.HoTen, COUNT(HopDong.IDKhachHang) as Solan from HopDong 
-- inner join KhachHang on HopDong.IDKhachHang = KhachHang.IDKhachHang 
-- where KhachHang.IDLoaiKhach = 1 group by HopDong.IDKhachHang order by Solan asc;



-- cau 5
-- Hiển thị IDKhachHang, HoTen, TenLoaiKhach, IDHopDong, TenDichVu, NgayLamHopDong, NgayKetThuc, TongTien (Với
-- TongTien được tính theo công thức như sau: ChiPhiThue + SoLuong*Gia, với SoLuong và Giá là từ bảng DichVuDiKem) cho tất cả
-- các Khách hàng đã từng đặt phỏng. (Những Khách hàng nào chưa từng đặt phòng cũng phải hiển thị ra).
use furama;

SELECT khachhang.idKhachHang,HoTen,loaikhachhang.TenLoaiKhachHang,hopdong.idHopDong,dichvu.TenDichVu,
hopdong.NgayBatDau as NgayLamHopDong,
hopdong.NgayKetThuc,
(ChiPhiThue+SoLuong*Gia )as TongTien
FROM khachhang 
left join hopdong on khachhang.idKhachHang=hopdong.idKhachHang
left join dichvu on dichvu.idDichVu= hopdong.idDichVu
left join hopdongchitiet on hopdongchitiet.idHopDong=hopdong.idHopDong
left join dichvudikem on dichvudikem.idDichVuDiKem =hopdongchitiet.idDichVuDiKem
left join loaikhachhang on loaikhachhang.idLoaiKhachHang=khachhang.idLoaiKhachHang
;


-- cau 6 Hiển thị IDDichVu, TenDichVu, DienTich, ChiPhiThue, TenLoaiDichVu của tất cả các loại Dịch vụ 
-- chưa từng được Khách hàng thực hiện đặt từ quý 1 của năm 2019 (Quý 1 là tháng 1, 2, 3).

use furama;

SELECT dichvu.idDichVu,dichvu.TenDichVu,dichvu.DienTich,dichvu.ChiPhiThue,loaidichvu.TenLoaiDichVu,
dichvudikem.tenDichVuDiKem
FROM dichvu
left join hopdong on hopdong.idDichVu=dichvu.idDichVu
left join loaidichvu on loaidichvu.idLoaiDichVu=dichvu.idLoaiDichVu
left join hopdongchitiet on hopdongchitiet.idHopDong=hopdong.idHopDong
left join dichvudikem on dichvudikem.idDichVuDiKem=hopdongchitiet.idDichVuDiKem
WHERE dichvu.idDichVu not in ( select idDichVu from hopdong 
							where year(hopdong.NgayBatDdau)=2019 and (month(hopdong.NgayBatDdau)=1
                            or month(hopdong.NgayBatDdau)=2 or month(hopdong.NgayBatDdau)=3 ) );


-- select dichvu.IDDichVu, dichvu.TenDichVu, dichvu.DienTich, dichvu.ChiPhiThue, loaidichvu.TenLoaiDichVu 
-- from dichvu join loaidichvu on loaidichvu.IDLoaiDichVu = dichvu.IDLoaiDichVu  
-- where dichvu.IDDichVu not in  (select IDDichVu from hopdong where year(NgayLam) = 2019 and quarter(NgayLam) = 1);

-- cau 7 Hiển thị thông tin IDDichVu, TenDichVu, DienTich, SoNguoiToiDa, ChiPhiThue, TenLoaiDichVu 
-- của tất cả các loại dịch vụ đã từng được Khách hàng đặt phòng trong năm 2018 nhưng chưa từng được Khách
-- hàng đặt phòng trong năm 2019.

use furama;
SELECT dichvu.idDichVu,dichvu.TenDichVu,dichvu.DienTich,dichvu.SoNguoiToiDa,dichvu.ChiPhiThue,
loaidichvu.TenLoaiDichVu
from dichvu
left join loaidichvu on loaidichvu.idLoaiDichVu=dichvu.idLoaiDichVu
where year(dichvu.TenDichVu)=2018 not in (select dichvu.TenDichVu where dichvu
									where year(dichvu.TenDichVu)=2019);

select year(dichvu.TenDichVu)=2018;


-- cau 8 Hiển thị thông tin HoTenKhachHang có trong hệ thống, với yêu cầu HoThenKhachHang không trùng nhau.
-- Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên

select DISTINCT khachhang.HoTen,khachhang.idKhachHang,khachhang.NgaySinh,khachhang.GioiTinh,khachhang.CMND,
khachhang.SoDT,khachhang.Email,khachhang.DiaChi
from khachhang;

select * from khachhang
where ;

-- cau 9 Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2019
-- thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.

use furama;
select count(month(hopdong.NgayBatDau)=)
from hopdong
group by count(month(hopdong.NgayBatDau));


-- cau 10 Hiển thị thông tin tương ứng với từng Hợp đồng thì đã sử dụng bao nhiêu Dịch vụ đi kèm. 
-- Kết quả hiển thị bao gồm IDHopDong, NgayLamHopDong, NgayKetthuc, TienDatCoc,
-- SoLuongDichVuDiKem (được tính dựa trên việc count các IDHopDongChiTiet).

use furama;

select hopdong.idHopDong, hopdong.NgayBatDau,hopdong.NgayKetThuc,TienDatCoc,
count(hopdongchitiet.idHopDongChiTiet) as SoLuongDichVuDiKem
from hopdong
left join hopdongchitiet on hopdongchitiet.idHopDong=hopdong.idHopDong
left join dichvudikem on dichvudikem.idDichVuDiKem=hopdongchitiet.idDichVuDiKem;
-- coi lai


-- cau 11 Hiển thị thông tin các Dịch vụ đi kèm đã được sử dụng bởi những Khách hàng có 
-- TenLoaiKhachHang là “Diamond” và có địa chỉ là “Vinh” hoặc “Quảng Ngãi”.

select loaikhachhang.TenLoaiKhachHang,tenDichVuDiKem,dichvudikem.Gia
from dichvudikem
left join hopdongchitiet on dichvudikem.idDichVuDiKem=hopdongchitiet.idDichVuDiKem
left join hopdong on hopdongchitiet.idHopDong=hopdong.idHopDong
left join khachhang on khachhang.idKhachHang=hopdong.idKhachHang
left join loaikhachhang on loaikhachhang.idLoaiKhachHang=khachhang.idLoaiKhachHang
where loaikhachhang.TenLoaiKhachHang='diamond' and (khachhang.DiaChi='Vinh' or khachhang.DiaChi='Quang Ngai');



-- cau 12 Hiển thị thông tin IDHopDong, TenNhanVien, TenKhachHang,
-- SoDienThoaiKhachHang, TenDichVu, SoLuongDichVuDikem (được
-- tính dựa trên tổng Hợp đồng chi tiết), TienDatCoc của tất cả các dịch vụ
-- đã từng được khách hàng đặt vào 3 tháng cuối năm 2019 nhưng chưa
-- từng được khách hàng đặt vào 6 tháng đầu năm 2019.

SELECT hopdong.idHopDong,nhanvien.HoTen as tennhanvien,khachhang.HoTen as tenkhachhang,
khachhang.SoDT as SDTkhachhang,dichvu.TenDichVu,
(hopdongchitiet.SoLuong*dichvudikem.gia) as SoLuongDichVuDikem,hopdong.TienDatCoc  
from hopdong
left join dichvu on dichvu.idDichVu=hopdong.idDichVu
left join khachhang on khachhang.idKhachHang=hopdong.idKhachHang
left join hopdongchitiet on hopdongchitiet.idHopDong=hopdong.idHopDong 
left join dichvudikem on dichvudikem.idDichVuDiKem=hopdongchitiet.idDichVuDiKem 
left join nhanvien on nhanvien.idNhanVien=hopdong.idNhanVien;



-- cau 14 Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một
-- lần duy nhất. Thông tin hiển thị bao gồm IDHopDong, TenLoaiDichVu, TenDichVuDiKem, SoLanSuDung.

SELECT hopdong.idHopDong, dichvudikem.tenDichVuDiKem,loaidichvu.TenLoaiDichVu,
sum  as SoLanSuDung
FROM hopdongchitiet
left join hopdong on hopdong.idHopDong=hopdongchitiet.idHopDong
left join dichvudikem on dichvudikem.idDichVuDiKem=hopdongchitiet.idDichVuDiKem;

-- 15 Hiển thi thông tin của tất cả nhân viên bao gồm IDNhanVien, HoTen, TrinhDo, TenBoPhan, SoDienThoai, 
-- DiaChi mới chỉ lập được tối đa 3 hợp đồng từ năm 2018 đến 2019.

SELECT nhanvien.idNhanVien,nhanvien.HoTen

-- cau 16 
select *
from nhanvien 
left join hopdong on nhanvien.idNhanVien=hopdong.idNhanVien
where (NgayBatDau between "2017-01-01" and "2017-01-01") or NgayBatDau is null ;

-- cau 20 Hiển thị thông tin của tất cả các Nhân viên và Khách hàng có trong hệ thống, thông tin hiển thị 
-- bao gồm ID (IDNhanVien, IDKhachHang), HoTen, Email, SoDienThoai, NgaySinh, DiaChi.

SELECT hopdong.idHopDong,nhanvien.idNhanVien,nhanvien.HoTen as TenNhanVien,
khachhang.idKhachHang,khachhang.HoTen as TenKhachHang,