# pmv.vim Package Manager for Vim

Vim plugin that provides functions to interact with your package/lib manager for your
favorite language and it's generic!

### Prerequisites

This plugin uses [mattn/webapi-vim](https://github.com/mattn/webapi-vim).

## Installation

**Installation with Vundle**
You can install this plugin using Vundle by using the path on GitHub for this repository.

```
Plugin 'mattn/webapi-vim'
Plugin 'carakan/pmv.vim'
```

## How to use

Automatically Pmv knows wich function needs to calculate functions for each package manager
with this functions:

### `PmvLatestRelease [package]`

Show the latest version of the package

### `PmvAllReleases [package]`

Leave your cursor on a line with a package name, or pass a name as only
argument to get all the releases for given package in a little pane.

```
:PmvAllReleases
    or
:PmvAllReleases mock

-------------------
0.1.3 (released on 2016-03-06)
0.1.2 (released on 2016-03-06)
0.1.1 (released on 2015-05-09)
0.1.0 (released on 2014-11-18)
```

### `PmvAppendRelease`

Leave your cursor on a line with a package name, (like `{:ecto` or even
`{:credo, only: [:dev, :test]}]`) and let the magic happen.

### `PmvPackageInfo [package]`

Leave your cursor on a line with a package name, or pass a name as only
argument to get info on the given package.

```
:PmvPackageInfo
    or
:PmvPackageInfo portmidi

-------------------
```

### `PmvOpenDocs [package]`

Open the hexdocs page for the given package (or in the line under the cursor)
in the system-default browser. This doesn't check if hexdocs are published for
a package, so you might get some 404's here and there.

Note: this uses `open` on OSX and `xdg-open` on Linux systems.

### `PmvOpenRepoPage [package]`

Open the github repo for the given package (or in the line under the cursor) in
the system-default browser.

Note: this uses `open` on OSX and `xdg-open` on Linux systems.

### Mappings

By default is:

| Mappings   | Command |
--------------------------------
| <leader>pm | :PmvLastRelease |
| <leader>pa | :PmvAllReleases |
| <leader>pp | :PmvAppendRelease |
| <leader>pi | :PmvPackageInfo |
| <leader>po | :PmvOpenRepoPage |
| <leader>pd | :PmvOpenDocs |


# TODO's

- Support languajes and package managers
  - [x] Elixir, hex
  - [x] NodeJS, npm/yarn
  - [x] Ruby, rubygems
- Refactor
- Async API calls
- Test's

# Inspiration

- [vim-rubygems](https://github.com/alexbel/vim-rubygems)
- [hex.vim](https://github.com/lucidstack/hex.vim)
