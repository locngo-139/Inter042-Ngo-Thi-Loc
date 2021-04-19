CREATE TABLE `bophan` (
  `idBoPhan` int NOT NULL,
  `BoPhan` varchar(45) COLLATE utf8mb4_general_ci NOT NULL
);
INSERT INTO `bophan` (`idBoPhan`, `BoPhan`) VALUES
(1, 'Sale - Marketing'),
(2, 'Hành chính'),
(3, 'Phục vụ'),
(4, 'Quản lý');


CREATE TABLE `dichvu` (
  `idDichVu` int NOT NULL,
  `TenDichVu` varchar(45)  NOT NULL,
  `DienTich` int NOT NULL,
  `SoTang` int DEFAULT NULL,
  `ChiPhiThue` double NOT NULL,
  `SoNguoiToiDa` int NOT NULL,
  `idKieuThue` int NOT NULL,
  `idLoaiDichVu` int NOT NULL,
  `TieuChuanPhong` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `MoTa` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `DienTichHoBoi` int DEFAULT NULL,
  `DichVuMienPhiDiKem` varchar(45) DEFAULT NULL
) ;

CREATE TABLE `dichvudikem` (
  `idDichVuDiKem` int NOT NULL,
  `tenDichVuDiKem` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  `DonVi` int NOT NULL,
  `Gia` double NOT NULL
);


INSERT INTO `dichvudikem` (`idDichVuDiKem`, `tenDichVuDiKem`, `DonVi`, `Gia`) VALUES
(1, 'Massage', 1, 100000),
(2, 'Karaoke', 1, 120000),
(3, 'Thức ăn', 1, 60000),
(4, 'Nước uống', 1, 30000),
(5, 'Thuê xe di chuyển', 1, 200000);


CREATE TABLE `hopdong` (
  `idHopDong` int NOT NULL,
  `idNhanVien` int NOT NULL,
  `idKhachHang` int NOT NULL,
  `idDichVu` int NOT NULL,
  `NgayBatDau` date NOT NULL,
  `NgayKetThuc` date NOT NULL,
  `TienDatCoc` double NOT NULL,
  `TongTien` double NOT NULL
);

CREATE TABLE `hopdongchitiet` (
  `idHopDongChiTiet` int NOT NULL,
  `idHopDong` int NOT NULL,
  `idDichVuDiKem` int NOT NULL,
  `SoLuong` int NOT NULL
);

CREATE TABLE `khachhang` (
  `idKhachHang` int NOT NULL,
  `HoTen` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `GioiTinh` bit(1) NOT NULL,
  `CMND` varchar(9) COLLATE utf8mb4_general_ci NOT NULL,
  `SoDT` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `Email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `idLoaiKhachHang` int NOT NULL,
  `DiaChi` varchar(100) COLLATE utf8mb4_general_ci NOT NULL
);

CREATE TABLE `kieuthue` (
  `idKieuThue` int NOT NULL,
  `TenKieuThue` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  `Gia` int NOT NULL
);

CREATE TABLE `loaidichvu` (
  `idLoaiDichVu` int NOT NULL,
  `TenLoaiDichVu` varchar(45) COLLATE utf8mb4_general_ci NOT NULL
);

CREATE TABLE `loaikhachhang` (
  `idLoaiKhachHang` int NOT NULL,
  `TenLoaiKhachHang` varchar(45) COLLATE utf8mb4_general_ci NOT NULL
);

INSERT INTO `loaikhachhang` (`idLoaiKhachHang`, `TenLoaiKhachHang`) VALUES
(1, 'Diamond'),
(2, 'Platinium'),
(3, 'Gold'),
(4, 'Silver'),
(5, 'Member');


CREATE TABLE `nhanvien` (
  `idNhanVien` int NOT NULL,
  `HoTen` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `NgaySinh` date NOT NULL,
  `CMND` varchar(9) COLLATE utf8mb4_general_ci NOT NULL,
  `SoDT` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `idTrinhDo` int NOT NULL,
  `idViTri` int NOT NULL,
  `Luong` double NOT NULL,
  `idBoPhan` int NOT NULL
);

CREATE TABLE `trinhdo` (
  `idTrinhDo` int NOT NULL,
  `TrinhDo` varchar(45) COLLATE utf8mb4_general_ci NOT NULL
);

INSERT INTO `trinhdo` (`idTrinhDo`, `TrinhDo`) VALUES
(1, 'Trung cấp'),
(2, 'Cao đẳng'),
(3, 'Đại học'),
(4, 'Sau đại học');

CREATE TABLE `vitri` (
  `idViTri` int NOT NULL,
  `ViTri` varchar(45) COLLATE utf8mb4_general_ci NOT NULL
);

INSERT INTO `vitri` (`idViTri`, `ViTri`) VALUES
(1, 'Lễ tân'),
(2, 'Phục vụ'),
(3, 'Chuyên viên'),
(4, 'Giám sát'),
(5, 'Quản lý'),
(6, 'Giám đốc');

ALTER TABLE `bophan`
  ADD PRIMARY KEY (`idBoPhan`);
  
  
  ALTER TABLE `dichvu`
  ADD PRIMARY KEY (`idDichVu`),
  ADD KEY `fk_dichvu_kieuthue_idx` (`idKieuThue`),
  ADD KEY `fk_dichvu_loaidichvu_idx` (`idLoaiDichVu`);
  
  ALTER TABLE `dichvudikem`
  ADD PRIMARY KEY (`idDichVuDiKem`);
  
  
  ALTER TABLE `hopdong`
  ADD PRIMARY KEY (`idHopDong`),
  ADD KEY `fk_hopdong_nhanvien_idx` (`idNhanVien`),
  ADD KEY `fk_hopdong_khachhang_idx` (`idKhachHang`),
  ADD KEY `fk_hopdong_dichvu_idx` (`idDichVu`);
  
  -- Chỉ mục cho bảng `hopdongchitiet`
--
ALTER TABLE `hopdongchitiet`
  ADD PRIMARY KEY (`idHopDongChiTiet`),
  ADD KEY `fk_hopdongchitiet_hopdong_idx` (`idHopDong`),
  ADD KEY `fk_hopdongchitiet_dchvudikem_idx` (`idDichVuDiKem`);
  
  
  ALTER TABLE `khachhang`
  ADD PRIMARY KEY (`idKhachHang`),
  ADD KEY `fk_khachhang_loaiKhachhang_idx` (`idLoaiKhachHang`);
  
  
  --
-- Chỉ mục cho bảng `kieuthue`
--
ALTER TABLE `kieuthue`
  ADD PRIMARY KEY (`idKieuThue`);

--
-- Chỉ mục cho bảng `loaidichvu`
--
ALTER TABLE `loaidichvu`
  ADD PRIMARY KEY (`idLoaiDichVu`);

--
-- Chỉ mục cho bảng `loaikhachhang`
--
ALTER TABLE `loaikhachhang`
  ADD PRIMARY KEY (`idLoaiKhachHang`);

--
-- Chỉ mục cho bảng `nhanvien`
--
ALTER TABLE `nhanvien`
  ADD PRIMARY KEY (`idNhanVien`),
  ADD KEY `fk_vitri_employee_idx` (`idViTri`),
  ADD KEY `fk_bophan_employee_idx` (`idBoPhan`),
  ADD KEY `fk_trinhdo_employee_idx` (`idTrinhDo`);

--
-- Chỉ mục cho bảng `trinhdo`
--
ALTER TABLE `trinhdo`
  ADD PRIMARY KEY (`idTrinhDo`);

--
-- Chỉ mục cho bảng `vitri`
--
ALTER TABLE `vitri`
  ADD PRIMARY KEY (`idViTri`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `bophan`
--
ALTER TABLE `bophan`
  MODIFY `idBoPhan` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `dichvu`
--
ALTER TABLE `dichvu`
  MODIFY `idDichVu` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `dichvudikem`
--
ALTER TABLE `dichvudikem`
  MODIFY `idDichVuDiKem` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `hopdong`
--
ALTER TABLE `hopdong`
  MODIFY `idHopDong` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `hopdongchitiet`
--
ALTER TABLE `hopdongchitiet`
  MODIFY `idHopDongChiTiet` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `khachhang`
--
ALTER TABLE `khachhang`
  MODIFY `idKhachHang` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `kieuthue`
--
ALTER TABLE `kieuthue`
  MODIFY `idKieuThue` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `loaidichvu`
--
ALTER TABLE `loaidichvu`
  MODIFY `idLoaiDichVu` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `loaikhachhang`
--
ALTER TABLE `loaikhachhang`
  MODIFY `idLoaiKhachHang` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT cho bảng `nhanvien`
--
ALTER TABLE `nhanvien`
  MODIFY `idNhanVien` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `trinhdo`
--
ALTER TABLE `trinhdo`
  MODIFY `idTrinhDo` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `vitri`
--
ALTER TABLE `vitri`
  MODIFY `idViTri` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;



-- chen them cot ngaySinh cho bang khachhang
ALTER TABLE `furama`.`khachhang` 
ADD COLUMN `NgaySinh` DATE NULL AFTER `HoTen`,
CHANGE COLUMN `idLoaiKhachHang` `idLoaiKhachHang` INT NOT NULL AFTER `idKhachHang`;



-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `dichvu`
--
ALTER TABLE `dichvu`
  ADD CONSTRAINT `fk_dichvu_kieuthue` FOREIGN KEY (`idKieuThue`) REFERENCES `kieuthue` (`idKieuThue`),
  ADD CONSTRAINT `fk_dichvu_loaidichvu` FOREIGN KEY (`idLoaiDichVu`) REFERENCES `loaidichvu` (`idLoaiDichVu`);

--
-- Các ràng buộc cho bảng `hopdong`
--
ALTER TABLE `hopdong`
  ADD CONSTRAINT `fk_hopdong_dichvu` FOREIGN KEY (`idDichVu`) REFERENCES `dichvu` (`idDichVu`),
  ADD CONSTRAINT `fk_hopdong_khachhang` FOREIGN KEY (`idKhachHang`) REFERENCES `khachhang` (`idKhachHang`),
  ADD CONSTRAINT `fk_hopdong_nhanvien` FOREIGN KEY (`idNhanVien`) REFERENCES `nhanvien` (`idNhanVien`);

--
-- Các ràng buộc cho bảng `hopdongchitiet`
--
ALTER TABLE `hopdongchitiet`
  ADD CONSTRAINT `fk_hopdongchitiet_dchvudikem` FOREIGN KEY (`idDichVuDiKem`) REFERENCES `dichvudikem` (`idDichVuDiKem`),
  ADD CONSTRAINT `fk_hopdongchitiet_hopdong` FOREIGN KEY (`idHopDong`) REFERENCES `hopdong` (`idHopDong`);

--
-- Các ràng buộc cho bảng `khachhang`
--
ALTER TABLE `khachhang`
  ADD CONSTRAINT `fk_khachhang_loaiKhachhang` FOREIGN KEY (`idLoaiKhachHang`) REFERENCES `loaikhachhang` (`idLoaiKhachHang`);

--
-- Các ràng buộc cho bảng `nhanvien`
--
ALTER TABLE `nhanvien`
  ADD CONSTRAINT `fk_bophan_employee` FOREIGN KEY (`idBoPhan`) REFERENCES `bophan` (`idBoPhan`),
  ADD CONSTRAINT `fk_trinhdo_employee` FOREIGN KEY (`idTrinhDo`) REFERENCES `trinhdo` (`idTrinhDo`),
  ADD CONSTRAINT `fk_vitri_employee` FOREIGN KEY (`idViTri`) REFERENCES `vitri` (`idViTri`);
  
  
  -- xoa cot addressi trong bang test
  --
  ALTER TABLE `loc`.`test` 
  DROP COLUMN `addressi`;
  
  -- cach chen them cot vao bang khachhang
  -- 
  ALTER TABLE khachhang ADD idLoaiKhachHang;
  
  
  INSERT INTO `furama`.`kieuthue`(`idKieuThue`, `TenKieuThue`, `Gia`)
  VALUES('1','thuê theo tháng',15000000);
  INSERT INTO `furama`.`kieuthue`(`idKieuThue`, `TenKieuThue`, `Gia`)
  VALUES('2','thuê theo ngày',500000);
  INSERT INTO `furama`.`kieuthue`(`idKieuThue`, `TenKieuThue`, `Gia`)
  VALUES('3','thuê theo năm',2000000000);
  
  
  INSERT INTO `furama`.`loaidichvu`(`idLoaiDichVu`, `TenLoaiDichVu`)
  VALUES('1','thuê villa');
  INSERT INTO `furama`.`loaidichvu`(`idLoaiDichVu`, `TenLoaiDichVu`)
  VALUES('2','thuê house');
  INSERT INTO `furama`.`loaidichvu`(`idLoaiDichVu`, `TenLoaiDichVu`)
  VALUES('3','thuê room');
  
  
  
INSERT INTO `furama`.`dichvu` (`idDichVu`, `TenDichVu`, `DienTich`, `SoTang`, `ChiPhiThue`, `idKieuThue`, `idLoaiDichVu`, `TieuChuanPhong`, `DienTichHoBoi`) 
VALUES ('1', 'villa', '150', '2', '10%', '1', '1', '5 sao', '10');
INSERT INTO `furama`.`dichvu` (`idDichVu`, `TenDichVu`, `DienTich`, `SoTang`, `ChiPhiThue`, `SoNguoiToiDa`, `idKieuThue`, `idLoaiDichVu`, `TieuChuanPhong`, `DienTichHoBoi`) 
VALUES ('1', 'villa', '200', '2', '10%', '6', '1', '1', '5 sao', '10');
INSERT INTO `furama`.`dichvu` (`idDichVu`, `TenDichVu`, `DienTich`, `SoTang`, `ChiPhiThue`, `SoNguoiToiDa`, `idKieuThue`, `idLoaiDichVu`, `TieuChuanPhong`) 
VALUES ('2', 'house', '75', '2', '10%', '5', '2', '2', '5 sao');
INSERT INTO `furama`.`dichvu` (`idDichVu`, `TenDichVu`, `DienTich`, `SoTang`, `ChiPhiThue`, `SoNguoiToiDa`, `idKieuThue`, `idLoaiDichVu`, `TieuChuanPhong`) 
VALUES ('2', 'house', '105', '2', '10%', '6', '2', '2', '5 sao');
INSERT INTO `furama`.`dichvu` (`idDichVu`, `TenDichVu`, `DienTich`, `SoTang`, `ChiPhiThue`, `SoNguoiToiDa`, `idKieuThue`, `idLoaiDichVu`, `TieuChuanPhong`) 
VALUES ('3', 'room ', '45', '15', '10%', '4', '3', '3', '5 sao');
INSERT INTO `furama`.`dichvu` (`idDichVu`, `TenDichVu`, `DienTich`, `SoTang`, `ChiPhiThue`, `SoNguoiToiDa`, `idKieuThue`, `idLoaiDichVu`, `TieuChuanPhong`) 
VALUES ('3', 'room', '30', '15', '10%', '2', '3', '3', '5 sao');
INSERT INTO `furama`.`dichvu` (`idDichVu`, `TenDichVu`, `DienTich`, `SoTang`, `ChiPhiThue`, `SoNguoiToiDa`, `idKieuThue`, `idLoaiDichVu`, `TieuChuanPhong`) 
VALUES ('3', 'room', '25', '15', '10%', '2', '3', '3', '5 sao');


insert into khachhang 
values (6,1,'Dinh Thanh Lam','1996-05-07',1,'0983','0713','lam@gmail.com','quang tri');

INSERT INTO `furama`.`hopdong` (`idHopDong`, `idNhanVien`, `idKhachHang`, `idDichVu`, `NgayBatDau`, `NgayKetThuc`, `TienDatCoc`, `TongTien`) 
VALUES ('1', '1', '3', '3', '2021-04-12', '2022-04-12', '5000000', '45000000');
INSERT INTO `furama`.`hopdong` (`idHopDong`, `idNhanVien`, `idKhachHang`, `idDichVu`, `NgayBatDau`, `NgayKetThuc`, `TienDatCoc`, `TongTien`) 
 VALUES('2', '2', '1', '4', '2021-03-15', '2022-03-15', '6000000', '75000000');

INSERT INTO `furama`.`hopdong` (`idHopDong`, `idNhanVien`, `idKhachHang`, `idDichVu`, `NgayBatDau`, `NgayKetThuc`, `TienDatCoc`, `TongTien`) 
VALUES ('3', '5', '1', '7', '2021-05-15', '2022-05-15', '5000000', '45000000');
INSERT INTO `furama`.`hopdong` (`idHopDong`, `idNhanVien`, `idKhachHang`, `idDichVu`, `NgayBatDau`, `NgayKetThuc`, `TienDatCoc`, `TongTien`) 
VALUES ('4', '3', '1', '6', '2021-10-09', '2023-10-09', '5000000', '90000000');


-- chen them vao barng hopdongchitiet
INSERT INTO `furama`.`hopdongchitiet` (`idHopDongChiTiet`, `idHopDong`, `idDichVuDiKem`, `SoLuong`) VALUES ('1', '1', '3', '1');
INSERT INTO `furama`.`hopdongchitiet` (`idHopDongChiTiet`, `idHopDong`, `idDichVuDiKem`, `SoLuong`) VALUES ('2', '2', '2', '1');
INSERT INTO `furama`.`hopdongchitiet` (`idHopDongChiTiet`, `idHopDong`, `idDichVuDiKem`, `SoLuong`) VALUES ('3', '3', '1', '1');
INSERT INTO `furama`.`hopdongchitiet` (`idHopDongChiTiet`, `idHopDong`, `idDichVuDiKem`, `SoLuong`) VALUES ('4', '4', '5', '1');
INSERT INTO `furama`.`hopdongchitiet` (`idHopDongChiTiet`, `idHopDong`, `idDichVuDiKem`, `SoLuong`) VALUES ('5', '1', '4', '1');


 -- thay đổi chi phi thue trong bang furama
 
UPDATE `furama`.`dichvu` SET `ChiPhiThue` = '40000' WHERE (`idDichVu` = '3');
UPDATE `furama`.`dichvu` SET `ChiPhiThue` = '45000' WHERE (`idDichVu` = '4');
UPDATE `furama`.`dichvu` SET `ChiPhiThue` = '35000' WHERE (`idDichVu` = '5');
UPDATE `furama`.`dichvu` SET `ChiPhiThue` = '30000' WHERE (`idDichVu` = '6');
UPDATE `furama`.`dichvu` SET `ChiPhiThue` = '30000' WHERE (`idDichVu` = '7');

-- chen them cho bang khachhang

INSERT INTO `furama`.`khachhang`
VALUES (7,1, 'Tran Van Nam', '1998-05-03', 0, '0732', '0176','nam@gmail.com','vinh');
