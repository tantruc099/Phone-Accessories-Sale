use master
go
create database QL_DTPK_test
go
drop database QL_DTPK_test
go
use QL_DTPK_test
go
create table SanPham(
	MaSP int identity not null,
	TenSP nvarchar(60),
	MoTa ntext,
	Gia int,
	HinhAnh varchar(255),
	MaDM int not null,
	SoLuongTon int,
	primary key (MaSP)
)
go
create table DanhMuc(
	MaDM int identity not null,
	TenDM nvarchar(40)
	primary key (MaDM)
)
go
create table KhachHang(
	MaKH int identity not null,
	HoTen nvarchar(40),
	DiaChi ntext,
	Email varchar(30),
	DienThoai char(10)
	primary key (MaKH)
)
go
create table HoaDon(
	MaHD int identity not null,
	MaKH int not null,
	NgayDat date,
	ThanhTien int,
	TrangThai ntext,
	primary key (MaHD)
)
go
create table ChiTietHD(
	MaCTHD int identity not null,
	MaHD int not null,
	MaSP int not null,
	SoLuong int,
	Gia int
	primary key (MaCTHD)
)
go
create table ThanhToan(
	MaTT int identity not null,
	MaHD int not null,
	PhuongThuc ntext,
	TrangThai ntext
	primary key (MaTT)
)
go
create table DanhGia(
	MaDG int identity not null,
	MaSP int not null,
	NoiDung ntext,
	DanhGiaSao int,
	MaKH int not null
	primary key (MaDG)
)
go
create table UserAccounts(
	ID_user int identity not null,
	username varchar(50) unique,
	password_user varchar(255),
	MaKH int not null,
	vaitro int default 0
	primary key (ID_user)
)
go
alter table SanPham add constraint FK_SP_DM foreign key (MaDM) references DanhMuc(MaDM)
alter table HoaDon add constraint FK_HD_KH foreign key (MaKH) references KhachHang(MaKH)
alter table ChiTietHD add constraint FK_CTHD_HD foreign key (MaHD) references HoaDon(MaHD)
alter table ChiTietHD add constraint FK_CTHD_SP foreign key (MaSP) references SanPham(MaSP)
alter table ThanhToan add constraint FK_TT_HD foreign key (MaHD) references HoaDon(MaHD)
alter table DanhGia add constraint FK_DG_SP foreign key (MaSP) references SanPham(MaSP)
alter table DanhGia add constraint FK_DG_KH foreign key (MaKH) references KhachHang(MaKH)
alter table UserAccounts add constraint FK_UC_KH foreign key (MaKH) references KhachHang(MaKH)
go
--insert into KhachHang
--values
--('KH001', N'Nhâm Trung Nghĩa', N'123 Tân Phú TP.HCM', 'nghianham@gmail.com', '0903376314'),
--('KH002', N'Liêu Hoàng Long', N'42 Gò Vấp TP.HCM', 'hoaron@gmail.com', '0908216313'),
--('KH003', N'Nguyễn Tấn Trực', N'32 Bình Chánh TP.HCM', 'tanbip@gmail.com', '0903373215'),
--('KH004', N'Lê Thánh Thiện', N'54 Tân Phú TP.HCM', 'tthien@gmail.com', '0964234123'),
--('KH005', N'Nguyễn Ngọc Ánh', N'47 Bình Dương TP.HCM', 'ngocanh@gmail.com', '0932132457'),
--('KH006', N'Trần Thu Trang', N'Cầu Giấy Hà Nội', 'thutrang@gmail.com', '0908546541'),
--('KH007', N'Lê Minh Tâm', N'Gò Xoài TP.HCM', 'tamm@gmail.com', '0975312345'),
--('KH008', N'Trần Thu Thảo', N'Sa Đéc Đồng Tháp', 'thuthao@gmail.com', '0906421321')
--select * from KhachHang
go
insert into DanhMuc
values
( N'Iphone'),
( N'Oppo'),
( N'Samsung'),
( N'Phụ kiện')
select * from DanhMuc
go
insert into SanPham
values
( N'IPhone 14 Pro Max 128GB', N'Cuối cùng thì chiếc iPhone 14 Pro Max cũng đã chính thức lộ diện tại sự kiện ra mắt thường niên vào ngày 08/09 đến từ nhà Apple, kết thúc bao lời đồn đoán bằng một bộ thông số cực kỳ ấn tượng cùng vẻ ngoài đẹp mắt sang trọng. Từ ngày 14/10/2022 người dùng đã có thể mua sắm các sản phẩm iPhone 14 series với đầy đủ phiên bản tại Thế Giới Di Động.', 33590000, 'IP1.jpg', 1, 200),
( N'IPhone 14 Pro 128GB', N'Tại sự kiện ra mắt sản phẩm thường niên diễn ra vào tháng 9/2022, Apple đã trình làng iPhone 14 Pro với những cải tiến về thiết kế màn hình, hiệu năng, sẵn sàng cùng bạn chinh phục mọi thử thách. Giờ đây người dùng đã có thể mua sắm những sản phẩm iPhone 14 series từ ngày 14/10/2022 tại Thế Giới Di Động với đầy đủ các phiên bản.', 30590000, 'IP2.jpg', 1, 200),
( N'IPhone 13 Pro Max 128GB', N'Điện thoại iPhone 13 Pro Max 128 GB - siêu phẩm được mong chờ nhất ở nửa cuối năm 2021 đến từ Apple. Máy có thiết kế không mấy đột phá khi so với người tiền nhiệm, bên trong đây vẫn là một sản phẩm có màn hình siêu đẹp, tần số quét được nâng cấp lên 120 Hz mượt mà, cảm biến camera có kích thước lớn hơn, cùng hiệu năng mạnh mẽ với sức mạnh đến từ Apple A15 Bionic, sẵn sàng cùng bạn chinh phục mọi thử thách.', 28990000, 'IP3.jpg', 1, 200),
( N'IPhone 13 Pro 128GB', N'Mỗi lần ra mắt phiên bản mới là mỗi lần iPhone chiếm sóng trên khắp các mặt trận và lần này cái tên khiến vô số người "sục sôi" là iPhone 13 Pro, chiếc điện thoại thông minh vẫn giữ nguyên thiết kế cao cấp, cụm 3 camera được nâng cấp, cấu hình mạnh mẽ cùng thời lượng pin lớn ấn tượng.', 25990000, 'IP4.jpg', 1, 200),
( N'IPhone 14 Plus 128GB', N'iPhone 14 Plus thu hút mọi ánh nhìn trong sự kiện Far Out diễn ra ngày 8/9 nhờ có vẻ ngoài cao cấp, trang bị bộ xử lý mạnh mẽ, cụm camera kép đặc trưng cho khả năng chụp ảnh cực nét cùng màn hình chất lượng cao cho bạn tận hưởng cảm giác sử dụng smartphone tuyệt vời hơn. Từ ngày 14/10/2022 người dùng đã có thể mua sắm các sản phẩm iPhone 14 series đầy đủ phiên bản tại Thế Giới Di Động.', 26790000, 'IP5.jpg', 1, 200),
( N'IPhone 14 128GB', N'Sau bao khoảng thời gian dài chờ đợi thì vào ngày 08/09 chiếc điện thoại iPhone 14 cũng đã chính thức được lộ diện, với hàng loạt thông số kỹ thuật ấn tượng từ camera cho đến hiệu năng cực khủng. Từ ngày 14/10/2022 tại Thế Giới Di Động cũng đã chính thức mở bán tất cả các phiên bản iPhone 14 series để người dùng có thể sớm ngày được trải nghiệm.', 23790000, 'IP6.jpg', 1, 200),
( N'IPhone 13 128GB', N'Trong khi sức hút đến từ bộ 4 phiên bản iPhone 12 vẫn chưa nguội đi, thì hãng điện thoại Apple đã mang đến cho người dùng một siêu phẩm mới iPhone 13 với nhiều cải tiến thú vị sẽ mang lại những trải nghiệm hấp dẫn nhất cho người dùng.', 20990000, 'IP7.jpg', 1, 200),
( N'IPhone 13 Mini 128GB', N'iPhone 13 mini được Apple ra mắt với hàng loạt nâng cấp về cấu hình và các tính năng hữu ích, lại có thiết kế vừa vặn. Chiếc điện thoại này hứa hẹn là một thiết bị hoàn hảo hướng tới những khách hàng thích sự nhỏ gọn nhưng vẫn giữ được sự mạnh mẽ bên trong.', 17490000, 'IP8.jpg', 1, 200),
( N'IPhone 12 64GB', N'Trong những tháng cuối năm 2020, Apple đã chính thức giới thiệu đến người dùng cũng như iFan thế hệ iPhone 12 series mới với hàng loạt tính năng bứt phá, thiết kế được lột xác hoàn toàn, hiệu năng đầy mạnh mẽ và một trong số đó chính là iPhone 12 64GB.', 16990000, 'IP9.jpg',  1, 200),
( N'IPhone 12 Mini 64GB', N'Điện thoại iPhone 12 mini 64 GB tuy là phiên bản thấp nhất trong bộ 4 iPhone 12 series, nhưng vẫn sở hữu những ưu điểm vượt trội về kích thước nhỏ gọn, tiện lợi, hiệu năng đỉnh cao, tính năng sạc nhanh cùng bộ camera chất lượng cao.', 13490000, 'IP10.jpg', 1, 200),
( N'IPhone 11 64GB', N'Apple đã chính thức trình làng bộ 3 siêu phẩm iPhone 11, trong đó phiên bản iPhone 11 64GB có mức giá rẻ nhất nhưng vẫn được nâng cấp mạnh mẽ như iPhone Xr ra mắt trước đó.', 12490000, 'IP11.jpg', 1, 200),
( N'IPhone SE 64GB', N'Như vậy là sau bao ngày chờ đợi thì iPhone SE 64GB (2022) cũng đã được giới thiệu tại sự kiện Apple Peek Performance. Thiết bị nổi bật với cấu hình mạnh mẽ, chạy chip hiện đại nhất của Apple hiện tại nhưng giá bán lại rất phải chăng.', 11490000, 'IP12.jpg', 1, 200),
( N'OPPO Reno8 Pro 5G', N'OPPO Reno8 Pro 5G ra mắt với sự đột phá về phần camera khi đây là thiết bị đầu tiên thuộc dòng Reno được tích hợp NPU MariSilicon X, được xem là NPU cao cấp nhất đến từ OPPO (2022) có khả năng xử lý hình ảnh đỉnh cao. Kèm với đó là một con chip mạnh mẽ đến từ nhà MediaTek giúp bạn có thể cân được mọi tựa game đang hiện hành.', 18990000, 'OP1.jpg', 2, 200),
( N'OPPO A55', N'OPPO cho ra mắt OPPO A55 4G chiếc smartphone giá rẻ tầm trung có thiết kế đẹp mắt, cấu hình khá ổn, cụm camera chất lượng và dung lượng pin ấn tượng, mang đến một lựa chọn trải nghiệm thú vị vừa túi tiền cho người tiêu dùng.', 4190000, 'OP2.jpg', 2, 200),
( N'OPPO Find X5 Pro 5G', N'OPPO Find X5 Pro 5G có lẽ là cái tên sáng giá được xướng tên trong danh sách điện thoại có thiết kế ấn tượng trong năm 2022. Máy được hãng cho ra mắt với một diện mạo độc lạ chưa từng có, cùng với đó là những nâng cấp về chất lượng ở camera nhờ sự hợp tác với nhà sản xuất máy ảnh Hasselblad.', 30490000, 'OP3.jpg', 2, 200),
( N'OPPO Reno6 5G', N'Sau khi ra mắt OPPO Reno5 chưa lâu thì OPPO lại cho ra mẫu smartphone mới mang tên OPPO Reno6 với hàng loạt cải tiến mới về ngoại hình bên ngoài lẫn hiệu năng bên trong, mang đến trải nghiệm vượt bật cho người dùng.', 10890000, 'OP4.jpg', 2, 200),
( N'OPPO Reno7Z 5G', N'OPPO đã trình làng mẫu Reno7 Z 5G với thiết kế OPPO Glow độc quyền, camera mang hiệu ứng như máy DSLR chuyên nghiệp cùng viền sáng kép, máy có một cấu hình mạnh mẽ và đạt chứng nhận xếp hạng A về độ mượt.', 9590000, 'OP5.jpg', 2, 200),
( N'OPPO A96', N'OPPO A96 là cái tên được nhắc đến khá nhiều trên các diễn đàn công nghệ hiện nay, nhờ sở hữu một ngoại hình hết sức bắt mắt cùng hàng loạt các thông số ấn tượng trong phân khúc giá như hiệu năng cao, camera chụp ảnh sắc nét', 6690000, 'OP6.jpg', 2, 200),
( N'OPPO A77S', N'OPPO vừa cho ra mắt mẫu điện thoại tầm trung mới với tên gọi OPPO A77s, máy sở hữu màn hình lớn, thiết kế đẹp mắt, hiệu năng ổn định cùng hàng loạt thông số nổi bật khác', 6290000, 'OP7.jpg', 2, 200),
( N'OPPO A95', N'Bên cạnh phiên bản 5G, OPPO còn bổ sung phiên bản OPPO A95 4G với giá thành phải chăng tập trung vào thiết kế năng động, sạc nhanh và hiệu năng đa nhiệm ấn tượng sẽ giúp cho cuộc sống của bạn thêm phần hấp dẫn, ngập tràn niềm vui', 6090000, 'OP8.jpg', 2, 200),
( N'OPPO A76', N'OPPO A76 4G ra mắt với thiết kế trẻ trung, hiệu năng ổn định, màn hình 90 Hz mượt mà cùng viên pin trâu cho thời gian sử dụng lâu dài phù hợp cho mọi đối tượng người dùng', 5690000, 'OP9.jpg', 2, 200),
( N'OPPO A57 64GB', N'Điện thoại OPPO A57 64GB vừa mới ra mắt đã tạo ấn tượng tích cực với cộng đồng yêu công nghệ. Sở hữu cho mình một thiết kế trẻ trung, hiệu năng mượt mà đáp ứng tốt nhu cầu cơ bản hằng ngày', 4190000, 'OP10.jpg', 2, 200),
( N'OPPO A17', N'Dường như OPPO đang ngày càng quan tâm đến trải nghiệm của người dùng, điều này được minh chứng qua nhiều dòng điện thoại của hãng trong đó có OPPO A17, máy sở hữu màn hình kích thước lớn, camera 50 MP đi cùng viên pin 5000 mAh với thời lượng dùng bền bỉ', 3990000, 'OP11.jpg', 2, 200),
( N'OPPO A54', N'OPPO tung ra mẫu điện thoại OPPO A54, được kế thừa thành công của OPPO A53, sở hữu bộ 3 camera AI thông minh, chấm camera selfie tinh tế nằm gọn trong màn hình tràn viền siêu rộng, vận hành mượt mà với hiệu năng ổn định và trở nên khác biệt so với các đối thủ trong tầm giá', 3890000, 'OP12.jpg', 2, 200),
( N'Samsung Galaxy Z Fold 4 5G 512GB', N'Với Samsung Galaxy Z Fold4, smartphone màn hình gập đã trở nên thân thiện, tiện dụng và bền bỉ hơn rất nhiều. Những cải tiến thiết thực trong từng khía cạnh giúp sản phẩm biến hóa linh hoạt hơn và đem lại những trải nghiệm không thể tìm thấy ở đâu khác.', 42490000, 'SS1.jpg', 3, 200),
( N'Samsung Galaxy Z Fold 3 5G 512GB', N'', 32990000, 'SS2.jpg', 3, 200),
( N'Samsung Galaxy S22 Ultra 5GB 512GB', N'Samsung Galaxy S22 Ultra 5G là siêu phẩm kế thừa tinh hoa Galaxy Note cùng đột phá Galaxy S, tạo nên sức mạnh vô song đỉnh cao. Điện thoại đã thiết lập chuẩn mực mới cho dòng smartphone cao cấp từ sức mạnh hàng đầu Snapdragon 8 Gen 1, camera “mắt thần bóng đêm”, khả năng zoom 100x, bút S-Pen tích hợp và thời gian sử dụng cả ngày dài. Đây là siêu phẩm tuyệt vời nhất mà Samsung từng mang đến.', 30490000, 'SS3.jpg', 3, 200),
( N'Samsung Galaxy Z Flip 4 5G Flex Mode Collection', N'Linh hoạt biến hóa, không ngừng sáng tạo, Samsung Galaxy Z Flip4 mang đến những xu hướng công nghệ hiện đại, đậm chất thời trang cho người dùng sành điệu. Nay điện thoại còn thêm phần cuốn hút với phiên bản giới hạn Samsung Galaxy Z Flip4 Flex Mode Collection – một sự kết hợp của Samsung và GIA STUDIOS cho phiên bản màu Pink Gold hoặc Blue.', 22990000, 'SS4.jpg', 3, 200),
( N'Samsung Galaxy S22 Plus 5G 256GB', N'Tận hưởng những công nghệ hàng đầu nhà Samsung, Galaxy S22 Plus 5G sẽ cho bạn trải nghiệm đỉnh cao từ thiết kế thời thượng, hiệu năng mạnh mẽ Snapdragon 8 Gen 1 và hệ thống camera đêm chuyên nghiệp nhất từ trước đến nay.', 22490000, 'SS5.jpg', 3, 200),
( N'Samsung Galaxy Z Flip 5G 256GB', N'Nhỏ gọn và tinh tế, Galaxy Z Flip4 là chiếc smartphone sinh ra dành cho các tín đồ thời trang. Cơ chế gập duyên dáng, bộ màu sắc nhẹ nhàng và loạt chức năng quay chụp sẽ làm say lòng những người yêu cái đẹp.', 22990000, 'SS6.jpg', 3, 200),
( N'Samsung Galaxy Z Flip 3 5G 256GB', N'Một biểu tượng thời trang, một kiệt tác của thế giới công nghệ mà ai cũng phải kinh ngạc khi nhìn thấy Samsung Galaxy Z Flip3 5G và cách mà bạn sử dụng siêu phẩm smartphone này, nơi công nghệ điện thoại màn hình gập đã mang đến những điều không tưởng.', 18490000, 'SS7.jpg', 3, 200),
( N'Samsung Galaxy S22 5G 256GB', N'', 18490000, 'SS8.jpg', 3, 200),
( N'Samsung Galaxy S22 Bora Purple', N'Bật nét kiêu kỳ, sẵn sàng trendy với phiên bản Samsung Galaxy S22 màu tím (Bora Purple), bạn sẽ trở nên thật thời thượng, ấn tượng và cá tính. Đồng hành đó là những công nghệ tốt nhất của Samsung từ hiệu năng Snapdragon 8 Gen 1, màn hình cao cấp cho đến hệ thống camera chuyên nghiệp.', 15990000, 'SS9.jpg', 3, 200),
( N'Samsung Galaxy S21 FE 5G 8GB - 256GB', N'Tuyệt phẩm dành cho các fan của Galaxy Phone đã xuất hiện, Samsung Galaxy S21 FE 5G dồn nén hàng loạt công nghệ ấn tượng chiều lòng người dùng như màn hình 120Hz siêu mượt, hệ thống camera chụp ảnh chuẩn studio, kết nối 5G tốc độ cao cùng cấu hình đặc biệt ấn tượng. Tất cả gói gọn trong một thân máy nhẹ nhàng với màu sắc đẳng cấp và trẻ trung.', 12990000, 'SS10.jpg', 3, 200),
( N'Samsung Galaxy A73 5G', N'Trải nghiệm hệ thống camera 108MP đầu tiên trên thế hệ Galaxy A, hiệu năng cực mạnh Snapdragon 778G, màn hình 120Hz mượt mà và kết nối 5G siêu tốc, Samsung Galaxy A73 5G đã sẵn sàng đưa bạn vào thế giới công nghệ đỉnh cao, giúp cuộc sống tiện lợi hơn bao giờ.', 10990000, 'SS11.jpg', 3, 200),
( N'Samsung Galaxy A23', N'Cùng tận hưởng những tác vụ giải trí, kết nối và làm việc theo cách ấn tượng nhất trên không gian hình ảnh V-Cut TFT 6.6 inch mà Samsung Galaxy A23 sở hữu. Sản phẩm đem lại nhiều trải nghiệm đơn giản nhưng hiệu quả, ghi nhận năng lực chụp ảnh xuất sắc qua hệ thống bốn camera được tích hợp chống rung quang học OIS.', 5590000, 'SS12.jpg', 3, 200),
( N'Sạc dự phòng 10000mAh Type C PD QC3.0 Hydrus PB299S Vàng', N'Pin sạc dự phòng 10000mAh Type C PD QC3.0 Hydrus PB299S Vàng sở hữu thiết kế đơn giản, màu sắc nổi bật, khối lượng gọn nhẹ, sạc pin tiện lợi và nhanh chóng mọi lúc mọi nơi.', 450000, 'AC1.jpg', 4, 200),
( N'Pin sạc dự phòng 10000mAh Type C PD QC3.0 Hydrus PB299S', N'Pin sạc dự phòng 10000mAh Type C PD QC3.0 Hydrus PB299S có kiểu dáng nhỏ gọn, màu sắc nổi bật, in hình hổ đáng yêu.', 600000, 'AC2.jpg', 4, 200),
( N'Cáp Type C - Lightning 1m Apple MM0A3 Trắng', N'Cáp Type C - Lightning 1m Apple MM0A3 Trắng sở hữu thiết kế đơn giản, độ dài 1 m cùng khả năng sạc nhanh lên đến 87 W chính là sự lựa chọn tuyệt vời cho các iFans chân chính.', 530000, 'AC3.jpg', 4, 200),
( N'Cáp Type C 2m Belkin CAB001', N'Sử dụng tiện lợi với thiết kế gọn nhẹ, dây dài 2 m. Chất liệu nhựa phủ bên ngoài dây giúp bảo vệ linh kiện bên trong, độ bền cao, chống rối dây hiệu quả.', 230000, 'AC4.jpg', 4, 200),
( N'Adapter Sạc Dual Type C 35W Apple MNWP3 Trắng', N'Adapter Sạc Dual Type C 35W Apple MNWP3 Trắng sở hữu gam màu trắng tươi sáng, sang trọng, dễ dàng mang theo khi di chuyển.', 1520000, 'AC5.jpg', 4, 200),
( N'Adapter Sạc Type C PD 25W Belkin WCA004', N'Tiết kiệm thời gian với chuẩn sạc nhanh Power Delivery, công suất tối đa 25 W', 490000, 'AC6.jpg', 4, 200),
( N'Tai nghe Bluetooth True Wireless OPPO ENCO Buds 2 ETE41', N'Thiết kế dạng tròn mới lạ, màu sắc thời thượng, sang trọng, hứa hẹn khả năng phát ra âm thanh chuẩn sống động và chi tiết tới từng âm bass, âm treble.', 1290000, 'AC7.jpg', 4, 200),
( N'Loa Bluetooth Fenda W5 Plus Xám', N'Thiết kế hiện đại, màu sắc bắt mắt, kết nối ổn định với các thiết bị khác trong phạm vi 10 m với kết nối Bluetooth 4.2.', 270000, 'AC8.jpg', 4, 200),
( N'Loa Bluetooth Fenda W5 Plus Xanh Navy', N'Loa Bluetooth Fenda W5 Plus Xanh Navy đem đến cho bạn một món phụ kiện cực kỳ nhỏ gọn, dễ dàng bỏ vào túi hoặc balo với âm thanh sống động, phù hợp cho nhu cầu giải trí cá nhân của bạn.', 360000, 'AC9.jpg', 4, 200),
( N'Ốp lưng iPhone 14 Pro Max Nhựa cứng viền dẻo Summer COSANO', N'Thiết kế ốp lưng tinh tế, màu sắc thời thượng, nổi bật. Nhựa cứng chất lượng giúp bảo vệ tối đa phần mặt lưng của thiết bị.', 150000, 'AC10.jpg', 4, 200),
( N'Ốp lưng Galaxy A04s Nhựa dẻo Samsung', N'Đường nét thiết kế đơn giản, màu đen trong đẹp mắt. Ốp lưng mỏng nhẹ với các đường bo góc mềm mại cho cảm giác cầm và sử dụng điện thoại thoải mái.', 200000, 'AC11.jpg', 4, 200)
select * from SanPham
go
select * from SanPham
select * from DanhMuc
select * from KhachHang
select * from UserAccounts
select * from DanhGia
go
INSERT INTO KhachHang
VALUES ('admin', N'admin', 'admin@gmail.com', '9999999999')
go
INSERT INTO UserAccounts
VALUES('admin','admin',1,1)
go


---------------------------------HÀM TH Hệ Quản trị ------------------

----------------------------------Trực--------------------
--ALTER TABLE ThanhToan
--ADD constraint TrangThai CHECK (TrangThai IN ('Đang xử lý', 'Đã thanh toán'));
-----------------
go
CREATE TRIGGER UpdateHoaDonTotal
ON ChiTietHD
AFTER INSERT ,UPDATE
AS
BEGIN
    UPDATE o
		SET o.ThanhTien =  (SELECT SUM(SoLuong * Gia) FROM  ChiTietHD od WHERE od.MaHD = o.MaHD) 
	FROM HoaDon o
	WHERE o.MaHD IN (SELECT MaHD FROM inserted) or o.MaHD in (Select MaHD from deleted);
END;

select* from HoaDon where MaHD='1'
------------ Trigger to update ThanhTien in HoaDon table after deleting ChiTietHD
go
CREATE TRIGGER UpdateHoaDonTotalOnDelete
ON ChiTietHD
AFTER DELETE
AS
BEGIN
    UPDATE o
		SET o.ThanhTien =  (SELECT SUM(SoLuong * Gia) FROM  ChiTietHD od WHERE od.MaHD = o.MaHD) 
	FROM HoaDon o
	WHERE o.MaHD IN (SELECT MaHD FROM inserted) or o.MaHD in (Select MaHD from deleted);
END;
select* from HoaDon where MaHD='HD011'
-------proc-------
go
------xem chi tiết hóa đơn khi nhập vào 1 mã HD
CREATE PROCEDURE GetOrderDetails
    @MaHD char(5)
AS
BEGIN
    SELECT
        CTHD.MaHD,
        SP.TenSP,
        CTHD.SoLuong,
        SP.Gia,
        CTHD.SoLuong * SP.Gia AS ThanhTien
    FROM
        ChiTietHD CTHD
    JOIN
        SanPham SP ON CTHD.MaSP = SP.MaSP
    WHERE
        CTHD.MaHD = @MaHD;
END;
exec dbo.GetOrderDetails 'HD001'
--------procedure cập nhật số lượng sản phẩm sau khi bán
go
CREATE PROCEDURE DecreaseProductQuantity
    @MaSP char(5),
    @SoLuongGiam int
AS
BEGIN
    -- Giảm số lượng sản phẩm
    UPDATE SanPham
    SET SoLuongTon = CASE
        WHEN SoLuongTon - @SoLuongGiam >= 0 THEN SoLuongTon - @SoLuongGiam
        ELSE 0
    END
    WHERE MaSP = @MaSP;
END;
exec dbo.DecreaseProductQuantity 'IP001',5
select* from SanPham where MaSP='IP001'
-------------function-------------------
--------lấy thông tin sản phẩm dựa trên loại sản phẩm(VD:'DienThoai')
go
CREATE FUNCTION GetProductInfoByCondition(@DK nvarchar(max))
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM SanPham
    WHERE TenSP LIKE '%' + @DK + '%'
);
SELECT * FROM GetProductInfoByCondition(N'Iphone')

-- function tính tổng số lượng sản phẩm trong một đơn hàng
go
CREATE FUNCTION CalculateTotalQuantityInOrder(@MaHD char(5))
RETURNS INT
AS
BEGIN
    DECLARE @TotalQuantity INT;
    SELECT @TotalQuantity = SUM(SoLuong)
    FROM ChiTietHD
    WHERE MaHD = @MaHD;

    RETURN ISNULL(@TotalQuantity, 0);
END;
SELECT dbo.CalculateTotalQuantityInOrder('HD001') AS SoLuong ;
----cursor---
------------------truy xuất dữ liệu -----------------
DECLARE @MaSP int
DECLARE @TenSP nvarchar(60)
DECLARE @MoTa ntext
DECLARE @Gia int
DECLARE @HinhAnh varchar(20)
DECLARE @MaDM int
DECLARE @SoLuongTon int

DECLARE ProductCursor CURSOR FOR
SELECT MaSP, TenSP, MoTa, Gia, HinhAnh, MaDM, SoLuongTon
FROM SanPham

OPEN ProductCursor

FETCH NEXT FROM ProductCursor INTO @MaSP, @TenSP, @MoTa, @Gia, @HinhAnh, @MaDM, @SoLuongTon
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Mã sản phẩm: ' + CAST(@MaSP AS varchar(10)) + ', Tên sản phẩm: ' + @TenSP

    FETCH NEXT FROM ProductCursor INTO @MaSP, @TenSP, @MoTa, @Gia, @HinhAnh, @MaDM, @SoLuongTon
END

CLOSE ProductCursor
DEALLOCATE ProductCursor








--------------------------------------------------------------------------------------------------------
------------------------------------------------PHÚ FUNCTION--------------------------------------------
ALTER TABLE ChiTietHD
ADD CONSTRAINT CK_SoLuong CHECK (SoLuong > 0);

-------------Hàm xem danh sách loại điện thoại---------------------
go
CREATE FUNCTION Xem_LoaiDT(@MaDM char(2))
RETURNS TABLE
AS
	RETURN(SELECT*FROM SanPham
	WHERE MaDM=@MaDM)
GO
SELECT*FROM dbo.Xem_LoaiDT('IP')
GO

-----------Hàm tính tổng tiền---------------
CREATE FUNCTION dbo.CalculateTotalPrice (
    @MaHD CHAR(5)
)
RETURNS INT
AS
BEGIN
    DECLARE @TotalPrice INT;
    SELECT @TotalPrice = SUM(SoLuong * Gia)
    FROM ChiTietHD
    WHERE MaHD = @MaHD;
    RETURN @TotalPrice;
END;

-----------------PROCEDURE--------------------------

--------------Xem chi tiết hóa đơn---------------------
go
CREATE PROCEDURE GetDetailedOrderInformation
    @OrderID char(5)
AS
BEGIN
    SELECT 
        HD.MaHD,
        HD.NgayDat,
        KH.HoTen AS CustomerName,
        SP.TenSP AS ProductName,
        CTHD.SoLuong,
        CTHD.Gia,
        HD.ThanhTien AS OrderTotal
    FROM HoaDon HD
    INNER JOIN KhachHang KH ON HD.MaKH = KH.MaKH
    INNER JOIN ChiTietHD CTHD ON HD.MaHD = CTHD.MaHD
    INNER JOIN SanPham SP ON CTHD.MaSP = SP.MaSP
    WHERE HD.MaHD = @OrderID;
END;
exec dbo.GetDetailedOrderInformation 'HD001'


-------------Tìm sản phẩm--------------------------
go
CREATE PROCEDURE SearchProductsByCategory
    @ID char(2)
AS
BEGIN
    SELECT 
        SP.MaSP,
        SP.TenSP,
        SP.MoTa,
        SP.Gia,
        SP.HinhAnh
    FROM SanPham SP
    INNER JOIN DanhMuc DM ON SP.MaDM = DM.MaDM
    WHERE DM.MaDM = @ID;
END;
-----cursor-----
--cập nhật dữ liệu
DECLARE @MaSPToUpdate int
DECLARE @GiaMoi int

DECLARE UpdateCursor CURSOR FOR
SELECT MaSP, Gia
FROM SanPham
WHERE Gia < 100 -- Bạn có thể đặt điều kiện của mình ở đây

OPEN UpdateCursor

FETCH NEXT FROM UpdateCursor INTO @MaSPToUpdate, @GiaMoi
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Logic cập nhật của bạn ở đây
    UPDATE SanPham
    SET Gia = @GiaMoi
    WHERE MaSP = @MaSPToUpdate

    FETCH NEXT FROM UpdateCursor INTO @MaSPToUpdate, @GiaMoi
END

CLOSE UpdateCursor
DEALLOCATE UpdateCursor

-----------TRG---------------
go
CREATE TRIGGER UpdateThanhTien
ON ChiTietHD
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE HoaDon
    SET ThanhTien = ThanhTien + (SELECT SUM(SoLuong * Gia) 
                                FROM ChiTietHD 
                                WHERE ChiTietHD.MaHD = HoaDon.MaHD)
    FROM HoaDon
    INNER JOIN inserted ON HoaDon.MaHD = inserted.MaHD;
END;


-----------Hào--------
------------PROC-------
GO
CREATE PROCEDURE UpdateDM
    @MaDM char(2),
    @DMM nvarchar(40)
AS
BEGIN
    UPDATE DanhMuc
    SET TenDM = @DMM
    WHERE MaDM = @MaDM;
END;

EXEC UpdateDM @MaDM = 'IP', @DMM = 'Iphone';

--------tìm KH dựa vào MaHD------------
go 
CREATE PROCEDURE TimKHbangMaHD
@MaHD char(5)
AS
BEGIN
SELECT
  KhachHang.MaKH,
  KhachHang.HoTen,
  KhachHang.DiaChi,
  KhachHang.Email,
  KhachHang.DienThoai
FROM
  HoaDon
INNER JOIN
  KhachHang
ON
  HoaDon.MaKH = KhachHang.MaKH
WHERE
  HoaDon.MaHD = @MaHD;
END;

EXEC TimKHbangMaHD 'HD003';
Drop Proc TimKHbangMaHD


--------------TRG---------------
---------Cập nhật email khách hàng khi đặt hàng--------
go
CREATE TRIGGER UpdateCustomerEmail
ON KhachHang
AFTER INSERT
AS
BEGIN
    UPDATE kh
    SET kh.Email = (SELECT Email FROM inserted WHERE MaKH = kh.MaKH)
    FROM KhachHang kh
    WHERE kh.MaKH IN (SELECT MaKH FROM inserted);
END;


-----------Kiểm tra tình trạng còn hàng của sản phẩm khi chèn chi tiết đơn hàng-----
go
--CREATE TRIGGER CheckProductAvailability
--ON ChiTietHD
--INSTEAD OF INSERT
--AS
--BEGIN
--    IF EXISTS (SELECT 1 FROM inserted i WHERE i.SoLuong > (SELECT SoLuongTon FROM SanPham WHERE MaSP = i.MaSP))
--    BEGIN
--        PRINT 'Không thể chèn chi tiết đơn hàng. Sản phẩm đã hết hàng.';
--    END
--    ELSE
--    BEGIN
--        INSERT INTO ChiTietHD (MaHD, MaSP, SoLuong, Gia)
--        SELECT MaHD, MaSP, SoLuong, Gia FROM inserted;
--    END
--END;

-------------FUNC----------
go
------Check-------
go
ALTER TABLE SanPham
ADD CONSTRAINT CK_SoLuongTon_Positive CHECK (SoLuongTon >= 0);





-----------------
------------LONG---------------
------------FUNCTION 1: Đánh giá trung bình của 1 sản phẩm
CREATE FUNCTION dbo.DanhGiaTrungBinh (@MaSP int)
RETURNS decimal(3, 2)
AS
BEGIN
    DECLARE @DGTB decimal(3, 2)
    
    SELECT @DGTB = AVG(DanhGiaSao)
    FROM DanhGia
    WHERE MaSP = @MaSP
    
    RETURN @DGTB
END
GO
DECLARE @MaSP int = 1;
DECLARE @DGTB decimal(3, 2)
SET @DGTB = dbo.DanhGiaTrungBinh(@MaSP)
SELECT @DGTB AS DanhGiaSaoTrungBinh;
GO

--FUCTION 2: Số hóa đơn đặt bởi 1 khách hàng
CREATE FUNCTION dbo.SoLuongHoaDonCuaKhachHang (@MaKH int)
RETURNS int
AS
BEGIN
    DECLARE @SLHD int

    SELECT @SLHD = COUNT(MaHD)
    FROM HoaDon
    WHERE MaKH = @MaKH

    RETURN @SLHD
END
GO
DECLARE @MaKH int = 1;
DECLARE @DemHD int
SET @DemHD = dbo.SoLuongHoaDonCuaKhachHang(@MaKH)
SELECT @DemHD AS SoLuongHoaDonCuaKhachHang;
GO


--PROCEDURE 1: Xoá hóa đơn
--DROP PROCEDURE dbo.XoaHoaDon;
CREATE PROCEDURE dbo.XoaHoaDon @MaHD int
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DELETE FROM ChiTietHD
        WHERE MaHD = @MaHD;

        DELETE FROM ThanhToan
        WHERE MaHD = @MaHD;

        DELETE FROM HoaDon
        WHERE MaHD = @MaHD;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

DECLARE @MaHDMuonXoa int = 22;
EXEC dbo.XoaHoaDon @MaHD = @MaHDMuonXoa;
GO

--PROCEDURE 2: Lấy 5 sản phẩm đắt nhất
CREATE PROCEDURE dbo.Lay5SanPhamDatNhat
AS
BEGIN
    SELECT TOP 5 TenSP AS ProductName, Gia AS Price
    FROM SanPham
    ORDER BY Gia DESC;
END
GO

EXEC dbo.Lay5SanPhamDatNhat;
GO

--CURSOR 1: Lấy tên sản phẩm và mô tả
DECLARE @MaSPCursor int
DECLARE @TenSP nvarchar(60)
DECLARE @MoTa nvarchar(max)

DECLARE ProductCursor CURSOR FOR
SELECT MaSP, TenSP, MoTa
FROM SanPham

OPEN ProductCursor
FETCH NEXT FROM ProductCursor INTO @MaSPCursor, @TenSP, @MoTa

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT N'Tên sản phẩm: ' + @TenSP + N', Mô tả: ' + CAST(@MoTa AS nvarchar(max))
    
    FETCH NEXT FROM ProductCursor INTO @MaSPCursor, @TenSP, @MoTa
END

CLOSE ProductCursor
DEALLOCATE ProductCursor
GO

--CURSOR 2: Lấy họ tên và địa chỉ khách hàng
DECLARE @MaKHCursor int
DECLARE @HoTen nvarchar(40)
DECLARE @DiaChi nvarchar(max)

DECLARE CustomerCursor CURSOR FOR
SELECT MaKH, HoTen, DiaChi
FROM KhachHang

OPEN CustomerCursor
FETCH NEXT FROM CustomerCursor INTO @MaKHCursor, @HoTen, @DiaChi

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT N'Họ tên Khách Hàng: ' + @HoTen + N', Địa chỉ: ' + CAST(@DiaChi AS nvarchar(max))
    
    FETCH NEXT FROM CustomerCursor INTO @MaKHCursor, @HoTen, @DiaChi
END

CLOSE CustomerCursor
DEALLOCATE CustomerCursor
GO