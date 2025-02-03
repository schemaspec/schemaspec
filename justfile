# List all available commands
default:
    @just --list

# Initialize development environment
init:
    #!/usr/bin/env bash
    if ! command -v uv &> /dev/null; then
        echo "Installing uv..."
        curl -LsSf https://astral.sh/uv/install.sh | sh
    fi
    just venv
    just install

# Create venv with uv
venv:
    uv venv

# Install dependencies with uv
install:
    uv pip install -e ".[dev]"

# Run tests
test:
    pytest

# Format code
fmt:
    ruff check . --fix
    ruff format .

# Type check
typecheck:
    mypy schemaspec tests

# Run all checks (format, typecheck, test)
check: fmt typecheck test
    @echo "All checks passed!"

# Clean up python cache files
clean:
    find . -type f -name "*.pyc" -delete
    find . -type d -name "__pycache__" -delete
    find . -type d -name "*.egg-info" -exec rm -r {} +
