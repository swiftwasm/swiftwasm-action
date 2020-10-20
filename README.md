# SwiftWasm GitHub Action

This action builds your project with the SwiftWasm toolchain and SDK, and has [`carton`](https://carton.dev) and its WebAssembly dependencies preinstalled.

## Inputs

### `shell-action`

**Optional** The shell command to run on your project. Default is `carton test`.

## Example usage

```yml
name: Build and test with SwiftWasm

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  swiftwasm_build:
    runs-on: ubuntu-20.04

    steps:
      - uses: actions/checkout@v2
      - uses: swiftwasm/swiftwasm-action@v5.3
        with:
          shell-action: carton test
```
