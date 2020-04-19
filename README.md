# SwiftWasm GitHub Action

This action builds your project with the SwiftWasm toolchain and SDK. This is still work in progress 
as we're fixing [current issues with SwiftPM support](https://github.com/swiftwasm/swift/issues/713).

## Inputs

### `swift-action`

**Optional** The command to run on your project. Default is `build`.

## Example usage

uses: swiftwasm/swiftwasm-action@master
with:
  swift-action: test
