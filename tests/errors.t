Elm is not installed:

  $ export PATH="$TESTDIR/bin"
  $ elm-upgrade
  ERROR: elm was not found on your PATH.  Make sure you have Elm 0.19 installed.
  Install Elm here https://guide.elm-lang.org/get_started.html#install
  [1]

Wrong Elm version installed:

  $ export PATH="$TESTDIR/bin_elm18:$TESTDIR/bin"
  $ elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm18/elm (re)
  ERROR: Elm 0.19 required, but found 0.18.0
  Install Elm here https://guide.elm-lang.org/get_started.html#install
  [1]

elm-format is not installed:

  $ export PATH="$TESTDIR/bin_elm19:$TESTDIR/bin"
  $ elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.0
  ERROR: elm-format was not found on your PATH.  Make sure you have elm-format installed.
  You can download Elm format here https://github.com/avh4/elm-format#installation-
  [1]

Wrong elm-format version installed:

  $ export PATH="$TESTDIR/bin_elm19:$TESTDIR/bin_old_elmformat:$TESTDIR/bin"
  $ elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.0
  INFO: Found elm-format at /.*/tests/bin_old_elmformat/elm-format (re)
  ERROR: elm-format >= 0.7.1-beta required, but found 0.7.0-exp
  You can download Elm format here https://github.com/avh4/elm-format#installation-
  [1]

Not an Elm project:

  $ export PATH="$TESTDIR/bin_elm19:$TESTDIR/bin_elmformat:$TESTDIR/bin"
  $ elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.0
  INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  INFO: Found elm-format 0.7.1-beta-rc1
  ERROR: You must run the upgrade from a folder containing elm-package.json
  [1]

Project uses wrong Elm version:

  $ export PATH="$TESTDIR/bin_elm19:$TESTDIR/bin_elmformat:$TESTDIR/bin"
  $ rsync -a "$TESTDIR/example_elm17/" ./
  $ elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.0
  INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  INFO: Found elm-format 0.7.1-beta-rc1
  ERROR: This is not an Elm 0.18 project.  Current project uses Elm 0.17.0 <= v < 0.18.0
  [1]
