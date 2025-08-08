# PHẦN BÀI TẬP: THỰC HÀNH VỚI JSON
### Bài 1: Kiểm tra chuỗi JSON sau có hợp lệ không?
{"Name": "An", "Age": 25, "Address": {"City": "HCM", "Zip": 700000}}

DECLARE @JSON NVARCHAR(MAX) = 
'{	"Name": "An", 
	"Age": 25, 
	"Address": {"City": "HCM", "Zip": 700000}}'
SELECT ISJSON(@JSON) AS isValid

isValid
1

--
### Bài 2: Trích xuất "City" trong chuỗi JSON ở trên.

DECLARE @JSON NVARCHAR(MAX) = 
'{	"Name": "An", 
	"Age": 25, 
	"Address": {"City": "HCM", "Zip": 700000}}'
SELECT JSON_VALUE(@JSON, '$.Name') AS Customer_name

Customer_name
An

### Bài 3: Dùng OPENJSON phân tích mảng:
{
  "Products": [
    {"SKU": "A001", "Price": 100},
    {"SKU": "A002", "Price": 150}
  ]
}
--> Phân tích mảng JSON có thể hiểu là dùng OPENJSON để chuyển đổi thành bảng và phân tích bằng SQL như bth
DECLARE @JSON NVARCHAR(MAX) = 
'{
  "Products": [
    {"SKU": "A001", "Price": 100},
    {"SKU": "A002", "Price": 150}
  ]
}'
--Lưu JSON vào bảng JSON_Products
CREATE TABLE JSON_Products(
	SKU_id NVARCHAR(50),
	price INT
	)
--Insert dữ liệu JSON vào bảng
INSERT INTO JSON_Products(SKU_id, price)
	SELECT SKU_id, price
	FROM OPENJSON (@JSON, '$.Products')
	WITH (
			SKU_id NVARCHAR(MAX) '$.SKU', --Lưu ý cần đúng path
			price INT '$.Price' --Lưu ý cần đúng path
		 )
SELECT * FROM JSON_Products

SKU_id	price
A001	100
A002	150

### Bài 4: Tạo bảng lưu trữ dữ liệu khách hàng dạng JSON. Thêm 2 bản ghi mẫu.
### Bài 5: Cập nhật trường "Name" trong dữ liệu JSON bằng JSON_MODIFY.
### Bài 6: Lọc danh sách khách hàng có "City" = 'Hanoi' trong dữ liệu JSON.
### Bài 7: Tạo cột ảo Phone từ JSON và đánh index để tối ưu truy vấn.
### Bài 8: Viết truy vấn trả về danh sách đơn hàng có giá trị > 500 từ JSON.
### Bài 9: Sử dụng JSON_QUERY để lấy toàn bộ "Orders" object từ cột JSON.
### Bài 10: So sánh hiệu năng truy vấn JSON khi có và không có index.
