@echo off
setlocal

REM Check if a name was provided
if "%~1"=="" (
    echo Please provide a project name.
    exit /b 1
)

set PROJECT_NAME=%~1



REM Step 1: Create the Vue project using Vite
echo Creating Vue project...
@pnpm create vite@latest %PROJECT_NAME% --template vue-ts
if errorlevel 1 (
    echo Error creating project. Deleting folder...
    rmdir /s /q "%PROJECT_NAME%"
    exit /b 1
)
cls
echo Creating Vue project...
echo accessing directory...
REM Step 2: Change to the project directory
cd %PROJECT_NAME% || (
    echo Error changing directory. Deleting folder...
    rmdir /s /q "%PROJECT_NAME%"
    exit /b 1
)
cls

REM Step 3: Install dependencies
echo Creating Vue project...
echo accessing directory...
echo Initializing...
@pnpm install
if errorlevel 1 (
    echo Error installing dependencies. Deleting folder...
    cd .. 2>nul
    rmdir /s /q "%PROJECT_NAME%"
    exit /b 1
)
cls

REM Step 4: Add dev dependencies
echo Creating Vue project...
echo accessing directory...
echo Initializing...
echo Adding development dependencies...
pnpm add -D @types/node tailwindcss autoprefixer
if errorlevel 1 (
    echo Error adding development dependencies. Deleting folder...
    cd .. 2>nul
    rmdir /s /q "%PROJECT_NAME%"
    exit /b 1
)
cls


REM Step 5: Add runtime dependencies
echo Creating Vue project...
echo accessing directory...
echo Initializing...
echo Adding development dependencies...
echo Adding runtime dependencies...
@pnpm add axios vue-router
if errorlevel 1 (
    echo Error adding runtime dependencies. Deleting folder...
    cd .. 2>nul
    rmdir /s /q "%PROJECT_NAME%"
    exit /b 1
)
cls
echo Creating Vue project...
echo accessing directory...
echo Initializing...
echo Adding development dependencies...
echo Adding runtime dependencies...
echo Creating vite configuration file...

REM Step 6: Create Vite config file using a temporary file
@set TEMP_FILE=vite.config.ts


@(
    echo import { fileURLToPath, URL } from 'url';
    echo import autoprefixer from 'autoprefixer';
    echo import tailwind from 'tailwindcss';
    echo import { defineConfig } from 'vite';
    echo import vue from '@vitejs/plugin-vue';
    echo // https://vite.dev/config/
    echo export default defineConfig({
    echo   css: {
    echo     postcss: {
    echo 	plugins: [tailwind^(^), autoprefixer^(^)],
    echo     },
    echo   },
    echo   plugins: [
    echo     vue^(^)
    echo   ],
    echo   server: {
    echo     port: 3000
    echo   },
    echo   resolve: {
    echo     alias: {
    echo       '@': fileURLToPath^(new URL^('./src', import.meta.url^)^)
    echo     }
    echo   },
    echo  optimizeDeps: {
    echo     entries: [],
    echo        }
    echo }^);    
) > "%TEMP_FILE%"

REM Move the temp file to the project directory

if errorlevel 1 (
    echo Error creating Vite config file. Deleting folder...
    cd .. 2>nul
    rmdir /s /q "%PROJECT_NAME%"
    exit /b 1
)
cls
echo Creating Vue project...
echo accessing directory...
echo Initializing...
echo Adding development dependencies...
echo Adding runtime dependencies...
echo Creating vite configuration file...

echo Project %PROJECT_NAME% initialized successfully!

@code .

endlocal

