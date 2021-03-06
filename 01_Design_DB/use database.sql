use furama;
-- cau 2 Hiển thị thông tin của tất cả nhân viên có trong hệ thống có tên bắt đầu là một trong các ký tự “H”, 
-- “T” hoặc “K” và có tối đa 15 ký tự.

select * 
from nhanvien
where (substring_index(HoTen, ' ', -1) like 'H%' or substring_index(HoTen, ' ', -1) like 'T%' 
or substring_index(HoTen, ' ', -1) like 'K%') and (char_length(HoTen)>=15);

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
GROUP BY hopdong.idKhachHang 
order by SoLanDatPhong  ;



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
dichvudikem.tenDichVuDiKem,hopdong.NgayBatDau
FROM dichvu
left join hopdong on hopdong.idDichVu=dichvu.idDichVu
left join loaidichvu on loaidichvu.idLoaiDichVu=dichvu.idLoaiDichVu
left join hopdongchitiet on hopdongchitiet.idHopDong=hopdong.idHopDong
left join dichvudikem on dichvudikem.idDichVuDiKem=hopdongchitiet.idDichVuDiKem
WHERE dichvu.idDichVu not in ( select idDichVu from hopdong 
							where year(hopdong.NgayBatDau)=2019 and (month(hopdong.NgayBatDau)=1
                            or month(hopdong.NgayBatDau)=2 or month(hopdong.NgayBatDau)=3 ) );


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
left join loaidichvu on dichvu.idLoaiDichVu=loaidichvu.idLoaiDichVu
where year(dichvu.TenDichVu)=2018 and (dichvu.TenDichVu not in (select dichvu.TenDichVu where dichvu
									where year(dichvu.TenDichVu)=2019));

select year(dichvu.TenDichVu)=2018;


-- cau 8 Hiển thị thông tin HoTenKhachHang có trong hệ thống, với yêu cầu HoThenKhachHang không trùng nhau.
-- Học viên sử dụng theo 3 cách khác nhau để thực hiện yêu cầu trên

select DISTINCT khachhang.HoTen,khachhang.idKhachHang,khachhang.NgaySinh,khachhang.GioiTinh,khachhang.CMND,
khachhang.SoDT,khachhang.Email,khachhang.DiaChi
from khachhang;

select *
from khachhang
group by khachhang.HoTen;

-- cau 9 Thực hiện thống kê doanh thu theo tháng, nghĩa là tương ứng với mỗi tháng trong năm 2019
-- thì sẽ có bao nhiêu khách hàng thực hiện đặt phòng.

use furama;
select monthname(hopdong.NgayBatDau)as months,month(hopdong.NgayBatDau)as month,count(*)
from hopdong
group by monthname(hopdong.NgayBatDau);

-- cach lay ngay tu chuoi
-- SELECT STR_TO_DATE("August 10 2017", "%M %d %Y")

-- SELECT 
--     (MONTH(birthday)) AS month, COUNT(*) AS number_of_birthdays
-- FROM
 --   friends
-- GROUP BY month
-- ORDER BY month ASC

-- cau 10 Hiển thị thông tin tương ứng với từng Hợp đồng thì đã sử dụng bao nhiêu Dịch vụ đi kèm. 
-- Kết quả hiển thị bao gồm IDHopDong, NgayLamHopDong, NgayKetthuc, TienDatCoc,
-- SoLuongDichVuDiKem (được tính dựa trên việc count các IDHopDongChiTiet).

use furama;

select DISTINCT hopdong.idHopDong, hopdong.NgayBatDau,hopdong.NgayKetThuc,TienDatCoc,
count(hopdongchitiet.idHopDongChiTiet) as SoLuongDichVuDiKem
from hopdong
left join hopdongchitiet on hopdongchitiet.idHopDong=hopdong.idHopDong
left join dichvudikem on dichvudikem.idDichVuDiKem=hopdongchitiet.idDichVuDiKem;
-- coi lai


-- cau 11 Hiển thị thông tin các Dịch vụ đi kèm đã được sử dụng bởi những Khách hàng có 
-- TenLoaiKhachHang là “Diamond” và có địa chỉ là “Vinh” hoặc “Quảng Ngãi”.

select loaikhachhang.TenLoaiKhachHang,tenDichVuDiKem,dichvudikem.Gia
from dichvudikem
 join hopdongchitiet on dichvudikem.idDichVuDiKem=hopdongchitiet.idDichVuDiKem
join hopdong on hopdongchitiet.idHopDong=hopdong.idHopDong
join khachhang on khachhang.idKhachHang=hopdong.idKhachHang
join loaikhachhang on loaikhachhang.idLoaiKhachHang=khachhang.idLoaiKhachHang
where loaikhachhang.TenLoaiKhachHang='diamond' and (khachhang.DiaChi='Vinh' or khachhang.DiaChi='Quang Ngai');



-- cau 12 Hiển thị thông tin IDHopDong, TenNhanVien, TenKhachHang,
-- SoDienThoaiKhachHang, TenDichVu, SoLuongDichVuDikem (được
-- tính dựa trên tổng Hợp đồng chi tiết), TienDatCoc của tất cả các dịch vụ
-- đã từng được khách hàng đặt vào 3 tháng cuối năm 2019 nhưng chưa
-- từng được khách hàng đặt vào 6 tháng đầu năm 2019.

SELECT hopdong.idHopDong,nhanvien.HoTen as tennhanvien,khachhang.HoTen as tenkhachhang,
khachhang.SoDT as SDTkhachhang,dichvu.TenDichVu,
(count(hopdongchitiet.idDichVuDiKem)) as SoLuongDichVuDikem,hopdong.TienDatCoc  
from hopdong
left join dichvu on dichvu.idDichVu=hopdong.idDichVu
left join khachhang on khachhang.idKhachHang=hopdong.idKhachHang
left join hopdongchitiet on hopdongchitiet.idHopDong=hopdong.idHopDong 
left join dichvudikem on dichvudikem.idDichVuDiKem=hopdongchitiet.idDichVuDiKem 
left join nhanvien on nhanvien.idNhanVien=hopdong.idNhanVien
where (hopdong.NgayBatDau between 2019-10-31 and 2019-12-31)and
 (hopdong.NgayBatDau not in (select hopdong.NgayBatDau from hopdong
			where hopdong.NgayBatDau between 2019-01-31 and 2019-06-31 ))
group by dichvu.TenDichVu ;



-- cau 13 Hiển thị thông tin các Dịch vụ đi kèm được sử dụng nhiều nhất bởi các. Khách hàng đã đặt phòng. 
-- (Lưu ý là có thể có nhiều dịch vụ có số lần sử dụng nhiều như nhau).

use furama;

select hopdongchitiet.idDichVuDiKem,dichvudikem.tenDichVuDiKem,
hopdongchitiet.idDichVuDiKem*hopdongchitiet.soluong as SoLanSuDung
FROM hopdongchitiet
left join dichvudikem on dichvudikem.idDichVuDiKem =hopdongchitiet.idDichVuDiKem
order by count(SoLanSuDung) DESC;


-- cau 14 Hiển thị thông tin tất cả các Dịch vụ đi kèm chỉ mới được sử dụng một
-- lần duy nhất. Thông tin hiển thị bao gồm IDHopDong, TenLoaiDichVu, TenDichVuDiKem, SoLanSuDung.

SELECT hopdong.idHopDong, dichvudikem.tenDichVuDiKem,loaidichvu.TenLoaiDichVu,
count(hopdongchitiet.idDichVuDiKem)  as SoLanSuDung
FROM hopdongchitiet
left join hopdong on hopdong.idHopDong=hopdongchitiet.idHopDong
left join dichvudikem on dichvudikem.idDichVuDiKem=hopdongchitiet.idDichVuDiKem
left join dichvu on dichvu.idDichVu= hopdong.idDichVu
left join loaidichvu on dichvu.idLoaiDichVu=loaidichvu.idLoaiDichVu
group by hopdong.idHopDong
having SoLanSuDung=1 ;

-- 15 Hiển thi thông tin của tất cả nhân viên bao gồm IDNhanVien, HoTen, TrinhDo, TenBoPhan, SoDienThoai, 
-- DiaChi mới chỉ lập được tối đa 3 hợp đồng từ năm 2018 đến 2019.

SELECT nhanvien.idNhanVien,nhanvien.HoTen,trinhdo.TrinhDo,bophan.BoPhan,nhanvien.SoDT,nhanvien.DiaChi
from nhanvien
left join trinhdo on trinhdo.idTrinhDo=nhanvien.idTrinhDo
left join bophan on bophan.idBoPhan=nhanvien.idBoPhan
left join hopdong on hopdong.idNhanVien=nhanvien.idNhanVien
where   (year(hopdong.NgayBatDau) between 2018 and 2019)
group by nhanvien.idNhanVien
having (count(hopdong.idHopDong)<= 3);
    
    

-- cau 16 Xóa những Nhân viên chưa từng lập được hợp đồng nào từ năm 2017 đến năm 2019.
SET SQL_SAFE_UPDATES = 0;
 delete from  furama.nhanvien
 where nhanvien.idNhanVien not in
( select nhanvien.idNhanVien
from furama.nhanvien 
left join hopdong on nhanvien.idNhanVien=hopdong.idNhanVien
where (NgayBatDau between "2017-01-01" and "2019-12-31") or NgayBatDau is null) ;

-- cau 17 Cập nhật thông tin những khách hàng có TenLoaiKhachHang từ Platinium lên Diamond, chỉ cập nhật 
-- những khách hàng đã từng đặt phòng với tổng Tiền thanh toán trong năm 2019 là lớn hơn 10.000.000 VNĐ.

select * 
from khachhang
left join loaikhachhang on loaikhachhang.idLoaiKhachHang=khachhang.idLoaiKhachHang
left join hopdong on hopdong.idKhachHang=khachhang.idKhachHang
where (hopdong.TongTien=10000000) and (loaikhachhang.TenLoaiKhachHang='diamond' 
or loaikhachhang.TenLoaiKhachHang='platinium');


-- cau 18 Xóa những khách hàng có hợp đồng trước năm 2016 (chú ý ràng buộc giữa các bảng).

delete from khachhang
where (select * from hopdong
	left join khachhang on khachhang.idKhachHang=hopdong.idHopDong
    where year(hopdong.NgayBatDau)<2016);
    
-- cau 19 Cập nhật giá cho các Dịch vụ đi kèm được sử dụng trên 10 lần trong năm 2019 lên gấp đôi.
update dichvudikem set gia=gia*2
where hopdongchitiet.idHopDongChiTiet (select hopdongchitiet.idHopDongChiTiet from hopdongchitiet
left join dichvudikem on hopdongchitiet.idDichVuDiKem=dichvudikem.idDichVuDiKem
left join hopdong on hopdong.idHopDong=hopdongchitiet.idHopDong
where year(hopdong.NgayBatDau)=2019
having count(hopdongchitiet.idDichVuDiKem)>10);

-- cau 20 Hiển thị thông tin của tất cả các Nhân viên và Khách hàng có trong hệ thống, thông tin hiển thị 
-- bao gồm ID (IDNhanVien, IDKhachHang), HoTen, Email, SoDienThoai, NgaySinh, DiaChi.

SELECT hopdong.idHopDong,nhanvien.idNhanVien,nhanvien.HoTen as TenNhanVien,
khachhang.idKhachHang,khachhang.HoTen as TenKhachHang,nhanvien.Email as EmailNhanVien,
khachhang.Email as EmailKhachHang,khachhang.Email as EmailKhachHang,khachhang.SoDT as SDTKhachHang,
khachhang.NgaySinh as NgaySinhKH,khachhang.DiaChi as DiaChiKH
from hopdong
left join nhanvien on nhanvien.idNhanVien=hopdong.idNhanVien
left join khachhang on khachhang.idKhachHang=hopdong.idKhachHang;







-- cau 21 Tạo khung nhìn có tên là V_NHANVIEN để lấy được thông tin của tất cả các nhân viên có địa chỉ 
-- là “Hải Châu” và đã từng lập hợp đồng cho 1 hoặc nhiều Khách hàng bất kỳ với ngày lập hợp đồng là “12/12/2019”

use furama;

DROP VIEW V_NHANVIEN;

create view V_NHANVIEN as 
select nhanvien.idNhanVien,nhanvien.HoTen from nhanvien
join hopdong on nhanvien.idNhanVien=hopdong.idNhanVien
where nhanvien.DiaChi like'%Hai Chau%' and hopdong.NgayBatDau='2019-12-12'  ;

alter view furama.V_NHANVIEN as select * from nhavien;

SELECT * FROM V_NHANVIEN;


-- cau 22 Thông qua khung nhìn V_NHANVIEN thực hiện cập nhật địa chỉ thành “Liên Chiểu” đối với 
-- tất cả các Nhân viên được nhìn thấy bởi khung nhìn này.

update V_NHANVIEN set DiaChi='Lien Chieu'
where ;


-- cau 23 Tạo Clustered Index có tên là IX_KHACHHANG trên bảng Khách hàng. Giải thích lý do và thực 
-- hiện kiểm tra tính hiệu quả của việc sử dụng INDEX

-- Index là dữ liệu có cấu trúc như B-Tree giúp cải thiện tốc độ tìm kiếm trên một bảng, làm giảm chi 
-- phí thực hiện truy vấn. Việc tối ưu hóa chỉ mục sẽ giúp xác định được vị trí của dữ liệu cần tìm 
-- thay vì phải dò theo thứ tự hàng triệu record trong bảng.

drop index IX_KHACHHANG on khachhang;

create index IX_KHACHHANG on khachhang(idKhachHang);



-- cau 24 Tạo Non-Clustered Index có tên là IX_SoDT_DiaChi trên các cột SODIENTHOAI và DIACHI 
-- trên bảng KHACH HANG và kiểm tra tính hiệu quả tìm kiếm sau khi tạo Index.

drop index IX_SoDT_DiaChi on khachhang;

create index IX_SoDT_DiaChi on khachhang(SoDT,DiaChi);



-- cau 25 Tạo Store procedure Sp_1 Dùng để xóa thông tin của một Khách hàng
-- nào đó với Id Khách hàng được truyền vào như là 1 tham số của Sp_1



DELIMITER //

CREATE PROCEDURE Sp_1(
in idSp int,
out message varchar(50)
)
if idSp in (select idKhachHang from khachhang) then

BEGIN
	delete from khachhang where khachhang.idKhachHang=idSp;
	set message="Da xoa khach hang";
/*** SQL for stored procedure ***/
END;
else
BEGIN
SET message = "Khach hang không tồn tại" ;
END;
END IF;

// DELIMITER  ;

call Sp_1;

-- cau 26 Tạo Store procedure Sp_2 Dùng để thêm mới vào bảng HopDong với yêu cầu Sp_2 phải thực hiện 
-- kiểm tra tính hợp lệ của dữ liệu bổ sung, với nguyên tắc không được trùng khóa chính và đảm bảo 
-- toàn vẹn tham chiếu đến các bảng liên quan.

DELIMITER //

CREATE PROCEDURE Sp_2(
	in idHD int,
	   idNV int,
       idKH int,
       idDV int,
       ngaybatdau date,
       ngayketthuc date,
       tiendatcoc double,
       tongtien double,
	out message varchar(50)
)
if idHD not in(select idHopDong from hopdong) then
begin
	insert into furama.hopdong set
    idHopDong=idD,
    idNhanVien=idNV,
    idKhachHang=idKH,
    idDichVu=idDV,
    NgayBatDau=ngaybatdau,
    NgayKetThuc=ngayketthuc,
    TienDatCoc=tiendatcoc,
    TongTien=tongtien;
    set message='Da Insert hop dong moi';
end;
else
set message='chua Insert duoc hop dong moi';
end if;
// DELIMITER  ;

EXEC Sp_2;

-- cau 27 Tạo triggers có tên Tr_1 Xóa bản ghi trong bảng HopDong thì hiển thị tổng số lượng bản ghi 
-- còn lại có trong bảng HopDong ra giao diện console của database

CREATE TRIGGER Tr_1 after delete on hopdong 
FOR EACH ROW  

-- update hopdong set new.tongsoluongbanghi=count(idHopDong)

-- cau 28 Tạo triggers có tên Tr_2 Khi cập nhật Ngày kết thúc hợp đồng, cần kiểm tra xem thời gian cập 
-- nhật có phù hợp hay không, với quy tắc sau: Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít 
-- nhất là 2 ngày. Nếu dữ liệu hợp lệ thì cho phép cập nhật, nếu dữ liệu không hợp lệ thì in ra thông báo 
-- “Ngày kết thúc hợp đồng phải lớn hơn ngày làm hợp đồng ít nhất là 2 ngày” trên console của database

-- cau 29 Tạo user function thực hiện yêu cầu sau:
-- a. Tạo user function func_1: Đếm các dịch vụ đã được sử dụng với Tổng tiền là &gt; 2.000.000 VNĐ.
-- b. Tạo user function Func_2: Tính khoảng thời gian dài nhất tính từ lúc bắt đầu làm hợp đồng đến lúc 
-- kết thúc hợp đồng mà Khách hàng đã thực hiện thuê dịch vụ (lưu ý chỉ xét các khoảng thời gian dựa vào
-- từng lần làm hợp đồng thuê dịch vụ, không xét trên toàn bộ các lần làm hợp đồng). Mã của Khách hàng 
-- được truyền vào như là 1 tham số của function này.

-- cau 30 Tạo Stored procedure Sp_3 để tìm các dịch vụ được thuê bởi khách hàng với loại dịch vụ 
-- là “Room” từ đầu năm 2015 đến hết năm 2019 để xóa thông tin của các dịch vụ đó (tức là xóa các 
-- bảng ghi trong bảng DichVu) và xóa những HopDong sử dụng dịch vụ liên quan (tức là phải xóa những
-- bản gi trong bảng HopDong) và những bản liên quan khác.

DELIMITER //
CREATE PROCEDURE Sp_3 (
in LoaiDichVu varchar(45),
OUT message VARCHAR(50)
)


//  DELIMITER ;



