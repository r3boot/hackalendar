BUILD_DIR = ./build
DATA_DIR  = ./data
CFG_DIR   = ./config

INFCLOUD_VERSION = 0.13.1
INFCLOUD_ZIP     = InfCloud_$(INFCLOUD_VERSION).zip
INFCLOUD_URL     = https://www.inf-it.com/$(INFCLOUD_ZIP)
INFCLOUD_CFG     = $(CFG_DIR)/infcloud
INFCLOUD_DIR     = $(BUILD_DIR)/infcloud
INFCLOUD_RW_DIR  = $(DATA_DIR)/infcloud-rw
INFCLOUD_RO_DIR  = $(DATA_DIR)/infcloud-ro
INFCLOUD_RW_CFG  = $(INFCLOUD_RW_DIR)/config.js
INFCLOUD_RO_CFG  = $(INFCLOUD_RO_DIR)/config.js

all: $(INFCLOUD_RW_CFG) $(INFCLOUD_RO_CFG)

$(BUILD_DIR):
	mkdir -p "$(BUILD_DIR)"

$(BUILD_DIR)/$(INFCLOUD_ZIP): $(BUILD_DIR)
	curl -L -o $(BUILD_DIR)/$(INFCLOUD_ZIP) $(INFCLOUD_URL)

$(INFCLOUD_DIR): $(BUILD_DIR)/$(INFCLOUD_ZIP)
	unzip -d $(BUILD_DIR) $(BUILD_DIR)/$(INFCLOUD_ZIP)

$(INFCLOUD_RW_DIR): $(INFCLOUD_DIR)
	cp -Rp $(INFCLOUD_DIR) $(INFCLOUD_RW_DIR)

$(INFCLOUD_RO_DIR): $(INFCLOUD_DIR)
	cp -Rp $(INFCLOUD_DIR) $(INFCLOUD_RO_DIR)

$(INFCLOUD_RW_CFG): $(INFCLOUD_RW_DIR)
	install -m 0644 $(INFCLOUD_CFG)/config-rw.js $(INFCLOUD_RW_DIR)/config.js

$(INFCLOUD_RO_CFG): $(INFCLOUD_RO_DIR)
	install -m 0644 $(INFCLOUD_CFG)/config-ro.js $(INFCLOUD_RO_DIR)/config.js

clean:
	[[ -d "$(BUILD_DIR)" ]] && rm -rf "$(BUILD_DIR)" || true
	[[ -d "$(INFCLOUD_RW_DIR)" ]] && rm -rf "$(INFCLOUD_RW_DIR)" || true
	[[ -d "$(INFCLOUD_RO_DIR)" ]] && rm -rf "$(INFCLOUD_RO_DIR)" || true
