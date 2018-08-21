## Development environment

### Setup

To do local development of elm-upgrade, you will need
[nodejs](https://nodejs.org),
[python](https://www.python.org/),
[jq](https://stedolan.github.io/jq/),
[rsync](https://rsync.samba.org/), and
[git](https://git-scm.com/).
They should all be available via your system's package manager.

Then, install [cram](https://bitheap.org/cram/) (which requires python):
```sh
pip install cram
cram --version
   # Cram CLI testing framework (version 0.7)
```

And install the node dependencies:

```sh
npm install
```

### Running tests

```sh
npm test
```

### Running elm-upgrade from source


```sh
npm install
npm link
```

You should now have `elm-upgrade` on your path.
