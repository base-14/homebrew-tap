# Base14 Homebrew Tap

This repository contains Homebrew formulas for Base14 tools.

## How to use

First, add this tap to your Homebrew:

```bash
brew tap base-14/homebrew-tap
```

Then you can install any formula from this tap:

```bash
brew install base-14/homebrew-tap/clamreef-agent
```

## Available Formulas

### ClamReef Agent

A lightweight control plane agent for ClamAV antivirus monitoring and telemetry.

```bash
# Install
brew install base-14/homebrew-tap/clamreef-agent

# Start as a service
brew services start base-14/homebrew-tap/clamreef-agent

# Check status
brew services list
```

## Adding New Formulas

To add a new formula to this tap:

1. Create a new `.rb` file in the `Formula/` directory
2. Follow the Homebrew formula documentation: https://docs.brew.sh/Formula-Cookbook
3. Test the formula locally:
   ```bash
   brew install --build-from-source Formula/<formula-name>.rb
   ```
4. Submit a pull request

## Development

### Testing a formula locally

```bash
# From the homebrew-tap directory
brew install --build-from-source ./Formula/clamreef-agent.rb

# Or if you've already tapped
brew reinstall --build-from-source base-14/homebrew-tap/clamreef-agent
```

### Auditing formulas

```bash
brew audit --strict Formula/clamreef-agent.rb
```

## License

See individual formula files for license information.