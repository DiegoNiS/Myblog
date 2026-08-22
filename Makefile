# Makefile para gestión y despliegue rápido del portafolio dante.duhvia.com

.PHONY: help dev build preview deploy clean

# Colores para consola
YELLOW := \033[33m
CYAN   := \033[36m
GREEN  := \033[32m
RESET  := \033[0m

## help: Muestra este menú de ayuda con todos los comandos disponibles
help:
	@echo ""
	@echo "$(CYAN)=========================================================$(RESET)"
	@echo "$(YELLOW)           DANTE.DUHVIA.COM - MAKEFILE HELP              $(RESET)"
	@echo "$(CYAN)=========================================================$(RESET)"
	@echo ""
	@echo "$(GREEN)Comandos disponibles:$(RESET)"
	@echo "  $(CYAN)make dev$(RESET)       - Inicia el servidor de desarrollo local de Astro"
	@echo "  $(CYAN)make build$(RESET)     - Compila el proyecto en estático (/dist)"
	@echo "  $(CYAN)make preview$(RESET)   - Previsualiza la build de producción localmente"
	@echo "  $(CYAN)make deploy$(RESET)    - Guarda los cambios (git commit) y los sube a GitHub (git push)"
	@echo "  $(CYAN)make clean$(RESET)     - Elimina la carpeta de compilación /dist y cachés de Astro"
	@echo "  $(CYAN)make help$(RESET)      - Muestra este panel de ayuda"
	@echo ""

## dev: Inicia el servidor de desarrollo local
dev:
	@echo "$(YELLOW)Iniciando servidor de desarrollo...$(RESET)"
	npx astro dev

## build: Compila el proyecto para producción
build:
	@echo "$(YELLOW)Compilando proyecto Astro en estático...$(RESET)"
	npx astro build

## preview: Previsualiza el proyecto construido localmente
preview: build
	@echo "$(YELLOW)Iniciando previsualización local...$(RESET)"
	npx astro preview

## deploy: Agrega todos los cambios, solicita un mensaje de commit y hace git push automático a GitHub
deploy:
	@echo "$(YELLOW)Preparando despliegue automático...$(RESET)"
	@git add .
	@read -p "Escribe el mensaje de commit (o presiona ENTER para 'update site content'): " msg; \
	if [ -z "$$msg" ]; then msg="update site content"; fi; \
	echo "$(CYAN)Guardando commit: '$$msg'...$(RESET)"; \
	git commit -m "$$msg"
	@echo "$(GREEN)Pusheando cambios a GitHub (main)...$(RESET)"
	git push origin main
	@echo "$(GREEN)✔ Cambios subidos exitosamente. GitHub Actions desplegará la web en 1 minuto en dante.duhvia.com.$(RESET)"

## clean: Limpia los archivos de build y caché
clean:
	@echo "$(YELLOW)Limpiando cachés y carpeta /dist...$(RESET)"
	rm -rf dist .astro
	@echo "$(GREEN)✔ Limpieza completada.$(RESET)"
