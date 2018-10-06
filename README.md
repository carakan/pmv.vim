# pmv.vim Package Manager for (Neo)Vim 

this vim plugin provides some nifty little functions to interact with your package
manager for all languages, it's generic!

### Prerequisites

This plugin uses [mattn/webapi-vim](https://github.com/mattn/webapi-vim) for making calls to the 
hex.pm API, so please make sure to have that cloned or in your list of plugins. 👌🏼

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

### `PmvAppendRelease`
Leave your cursor on a line with a package name, (like `{:ecto ` or even
`{:credo, only: [:dev, :test]}]`) and let the magic happen.

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

### `PmvAllVersions [package]`
Just an alias for `PmvAllReleases` ☝🏼

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
in the system-default browser.  This doesn't check if hexdocs are published for
a package, so you might get some 404's here and there.

Note: this uses `open` on OSX and `xdg-open` on Linux systems.

### `PmvOpenRepoPage [package]`
Open the github repo for the given package (or in the line under the cursor) in
the system-default browser.

Note: this uses `open` on OSX and `xdg-open` on Linux systems.

# TODO's
- Support all possible languajes and package manager. 
  - [x] Elixir
  - [x] NodeJS
  - [x] Ruby
- Refactor's
