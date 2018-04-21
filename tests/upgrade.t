Upgrading a package from Elm 0.18 to Elm 0.19

  $ export PATH="$TESTDIR/bin_elm19:$TESTDIR/bin_elmformat:$TESTDIR/bin"
  $ rsync -a "$TESTDIR/example_elm18/" ./
  $ elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.0
  INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  INFO: Found elm-format 0.7.1-beta-rc1
  INFO: Cleaning ./elm-stuff before upgrading
  INFO: Changing elm-package.json#elm-version to "0.18.0 <= v < 0.19.0"
  TODO: not yet implemented
