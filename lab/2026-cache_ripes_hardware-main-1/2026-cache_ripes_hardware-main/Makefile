RIPES_API  := https://api.github.com/repos/mortbopet/Ripes/releases/latest
RIPES_DIR  := Ripes
BIN_DIR    := bin

.PHONY: all help deps submodule ripes

all: help

help:
	@echo "Targets disponibles:"
	@echo "  make deps    — clona el submodulo de RIPES e instala gcc-riscv64-unknown-elf y yosys (requiere sudo)"
	@echo "  make ripes   — descarga el AppImage de RIPES (ultima version) y lo configura"

## Clona/actualiza el submodulo con el codigo fuente de RIPES (referencia)
submodule:
	git submodule update --init --recursive

## Instala dependencias del sistema (incluye el submodulo de RIPES)
deps: submodule
	sudo ./install_deps.sh

## Descarga RIPES AppImage desde la pagina oficial y configura el compilador
ripes: $(BIN_DIR)/Ripes.AppImage
	@echo "Configurando compilador C en RIPES..."
	chmod +x scripts/setup_compiler.sh
	scripts/setup_compiler.sh
	@echo ""
	@echo "Listo. Ejecutar con: ./$(BIN_DIR)/Ripes.AppImage"

$(BIN_DIR)/Ripes.AppImage:
	@mkdir -p $(BIN_DIR)
	@echo "Consultando ultima version de RIPES..."
	$(eval RIPES_URL := $(shell curl -s $(RIPES_API) \
	    | python3 -c "import sys,json; r=json.load(sys.stdin); \
	      [print(a['browser_download_url']) for a in r['assets'] \
	       if 'linux-x86_64.AppImage' in a['name']]"))
	@echo "Descargando: $(RIPES_URL)"
	curl -L -o $(BIN_DIR)/Ripes.AppImage "$(RIPES_URL)"
	chmod +x $(BIN_DIR)/Ripes.AppImage
	@echo "AppImage guardado en: $(BIN_DIR)/Ripes.AppImage"
