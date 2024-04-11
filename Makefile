SRC_DIR := src/
BUILD_DIR := build/
BIN_DIR := build/bin/
OBJ_DIR := build/obj/

# Path: Source files
SRC_FILES := $(wildcard $(SRC_DIR)*.c)
OBJ_FILES := $(patsubst $(SRC_DIR)%.c, $(OBJ_DIR)%.o, $(SRC_FILES))

# Compiler
CC := gcc
CFLAGS := -Wall \
		-std=c17 \
		-g
LDFLAGS := -lm
LD := ld

# Target
TARGET := $(BIN_DIR)ccpu

# Default target
all: $(TARGET)

# Linking
$(TARGET): $(OBJ_FILES)
	@echo "Linking $^"
	@mkdir $(BIN_DIR) -p
	@$(CC) $(LDFLAGS) -o $@ $^ $(CFLAGS)

# Compiling
$(OBJ_DIR)%.o: $(SRC_DIR)%.c
	@echo "Compiling $<"
	@mkdir $(OBJ_DIR) -p
	@$(CC) $(CFLAGS) -c -o $@ $<

# Clean
clean:
	@echo "Cleaning up"
	@rm -rf $(BIN_DIR)/* $(OBJ_DIR)/*

# Run
run: $(TARGET)
	@echo "Running $(TARGET)"
	@$(TARGET)

# Debug
debug: $(TARGET)
	@echo "Debugging $(TARGET)"
	gdb $(TARGET)

# Phony
.PHONY: all clean run debug