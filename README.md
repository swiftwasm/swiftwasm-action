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

## Usage with GitHub Pages

[GitHub Pages](https://pages.github.com/) is an easy way to host SwiftWasm apps. Follow [the GitHub Pages guide](https://guides.github.com/features/pages/), and then use an appropriate action after running `carton bundle` to publish the results:

```yml
name: Deploy to GitHub Pages

on:
  push:
    branches: [main]

jobs:
  swiftwasm_deploy:
    runs-on: ubuntu-20.04

    steps:
      - uses: actions/checkout@v2

      - uses: swiftwasm/swiftwasm-action@v5.3
        with:
          shell-action: carton bundle

      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./Bundle
```
