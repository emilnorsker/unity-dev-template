# Unity Minimal Project

A minimal Unity project setup with testing capabilities, using Nix for reproducible development environments.

## Features

- 🎮 Unity 6000.0.34f1
- 🧪 Unity Test Framework
- ❄️ Nix development environment
- 🔧 Just task runner for common operations

## Prerequisites

- Nix package manager
- Unity account (for license)
- Git

## Getting Started

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd unityminimal
   ```

2. Copy the environment template:
   ```bash
   cp .template.env .env
   ```

3. Fill in your Unity credentials in `.env`

4. Enter the development shell:
   ```bash
   nix develop
   ```

5. Start Unity:
   ```bash
   just unity
   ```

## Development

- Run tests:
  ```bash
  just unity -batchmode -runTests
  ```

## Project Structure

- `UnityProject/` - Unity project files
- `flake.nix` - Nix development environment
- `justfile` - Task runner commands
- `.env` - Local environment configuration 