# Makefile for flashing AVR
Makefile để nạp code cho AVR (không cần dùng IDE):
- Tự động lập depedency giữa header file và source code.
- Tự động tìm source code và header file (cần phải để đúng directory).
## Thiết lập toolchain
Dành cho Linux/Ubuntu
```
sudo apt-get install avrdude binutils-avr avr-libc gcc-avr
```
## Cấu trúc file
```
├── build
├── core
    ├── include
        ├── timer.h
    └── timer.c ...    
├── lib
    ├── include
        ├── lcd.h
    └── lcd.c
├── src
    ├── main.c
└── makefile
```
`build` chứa file sau khi compile (.o, .elf, .hex)
## Nạp code bằng command line
```
make flash
```
