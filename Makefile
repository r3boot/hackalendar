BUILD_DIR = ./build
DATA_DIR  = ./data

INFCLOUD_VERSION = 0.13.1
INFCLOUD_ZIP     = InfCloud_$(INFCLOUD_VERSION).zip
INFCLOUD_URL     = https://www.inf-it.com/$(INFCLOUD_ZIP)
INFCLOUD_DIR     = $(DATA_DIR)/infcloud

all: $(INFCLOUD_DIR)

$(BUILD_DIR):
	mkdir -p "$(BUILD_DIR)"

$(BUILD_DIR)/$(INFCLOUD_ZIP): $(BUILD_DIR)
	curl -L -o $(BUILD_DIR)/$(INFCLOUD_ZIP) $(INFCLOUD_URL)

$(INFCLOUD_DIR): $(BUILD_DIR)/$(INFCLOUD_ZIP)
	unzip -d $(DATA_DIR) $(BUILD_DIR)/$(INFCLOUD_ZIP)

clean:
	[[ -d "$(BUILD_DIR)" ]] && rm -rf "$(BUILD_DIR)" || true