MCU = atmega16
F_CPU = 1000000UL
BAUD = 19200
TARGET = blinkLED

PROGRAMMER_TYPE = avrisp
PROGRAMMER_PORT = /dev/ttyUSB0
# Programmer port and baud rate is necessary for avrisp
PROGRAMMER_ARGS = -p $(MCU) -c $(PROGRAMMER_TYPE)  -P $(PROGRAMMER_PORT) -b $(BAUD)

CC = avr-gcc
OBJCOPY = avr-objcopy	
AVRDUDE = avrdude

CPPFLAGS = -DF_CPU=$(F_CPU) -I$(INCLUDE_DIR) -I$(LIB_DIR)
CFLAGS = -Os -g -Wall
DEPFLAGS = -MMD -MP
TARGET_ARCH = -mmcu=$(MCU)

SOURCE_DIR = src
BUILD_DIR = build
INCLUDE_DIR = include
LIB_DIR = lib
SOURCES = $(wildcard $(SOURCE_DIR)/*.c $(LIB_DIR)/*.c)
OBJECTS = $(patsubst %.c,$(BUILD_DIR)/%.o,$(notdir $(SOURCES))) 

.PHONY: all clean flash
# To prevent implicit cleanup
.SECONDARY: $(TARGET).elf $(TARGET).hex

test:
	$(AVRDUDE) $(PROGRAMMER_ARGS) -U lfuse:r:-:h

all: $(BUILD_DIR)/$(TARGET).hex

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf
	$(OBJCOPY) -O ihex $< $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS)
	$(CC) $(TARGET_ARCH) -o $@ $^

$(BUILD_DIR)/%.o: $(SOURCE_DIR)/%.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) $(DEPFLAGS) -MF $(@:.o=.d) -c -o $@ $<

$(BUILD_DIR)/%.o: $(LIB_DIR)/%.c
	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) $(DEPFLAGS) -MF $(@:.o=.d) -c -o $@ $<

-include $(wildcard $(BUILD_DIR)/*.d)

clean:
	rm -f $(wildcard $(BUILD_DIR)/*)

flash: $(BUILD_DIR)/$(TARGET).hex 
	$(AVRDUDE) $(PROGRAMMER_ARGS) -U flash:w:$<