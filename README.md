# SwiftWasm GitHub Action

This action builds your project with the SwiftWasm toolchain and SDK.

## Inputs

### `swift-action`

**Optional** The command to run on your project. Default is `build --triple wasm32-unknown-wasi`.

## Example usage

```yml
uses: swiftwasm/swiftwasm-action@master
with:
  swift-action: build --triple wasm32-unknown-wasi
```
