# Ingredex Frontend Makefile

.PHONY: help run get analyze test build-apk build-web

help:
	@echo Ingredex Frontend Commands:
	@echo   make run        - Run Flutter application (flutter run)
	@echo   make get        - Fetch Flutter pub dependencies (flutter pub get)
	@echo   make analyze    - Analyze Dart code (flutter analyze)
	@echo   make test       - Run Flutter widget tests (flutter test)
	@echo   make build-apk  - Build Android APK release
	@echo   make build-web  - Build Web release bundle

run:
	flutter run

get:
	flutter pub get

analyze:
	flutter analyze

test:
	flutter test

build-apk:
	flutter build apk --release

build-web:
	flutter build web --release
