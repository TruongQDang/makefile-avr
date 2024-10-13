# Makefile for flashing AVR
Makefile để nạp code cho AVR (không cần dùng IDE):
- Tự động lập depedency giữa header file và source code.
- Tự động tìm source code và header file (cần phải để đúng directory).
## Cấu trúc file
```
├── build
├── src
├── include
├── lib
├── makefile
```
`build` chứa file sau khi compile (.o, .elf, .hex)
`src` chứa source code
`include` chứa header file của source code
`lib` chứa source code và header file của lib
## Hướng dẫn dùng makefile
Nếu dùng Arduino làm mạch nạp:
- Sửa model của vi điều khiển: MCU
- Sửa clock frequency: F_CPU
Nếu dùng mạch nạp khác:
- Sửa model của vi điều khiển: MCU
- Sửa clock frequency: F_CPU
- Sửa tên mạch nạp: PROGRAMMER_TYPE
- Bỏ PROGRAMMER_PORT
- Bỏ BAUD
## Nạp code bằng command line
```
make flash
```
