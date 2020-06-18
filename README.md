# SwiftWasm GitHub Action

This action builds your project with the SwiftWasm toolchain and SDK.

## Inputs

### `shell-action`

**Optional** The shell command to run on your project. Default is `swift build --triple wasm32-unknown-wasi`.

## Example usage

```yml
name: Build with SwiftWasm

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  linux_build:
    runs-on: ubuntu-20.04

    steps:
      - uses: actions/checkout@v2
      - uses: swiftwasm/swiftwasm-action@master
        with:
          shell-action: swift build --triple wasm32-unknown-wasi
```
