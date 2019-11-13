Commonly used "BSD3" license should be normalized to "BSD-3-Clause"

  $ export PATH="$TESTDIR/bin_elm19:$TESTDIR/bin_elmformat:$TESTDIR/bin"
  $ rsync -a "$TESTDIR/example_elm18_package/" ./
  $ jq '.license = "BSD3"' "$TESTDIR/example_elm18_package/elm-package.json" > elm-package.json
  $ git init -q && git add . && git commit -q -m "."
  $ elm-upgrade
  INFO: Found elm at /.*/tests/bin_elm19/elm (re)
  INFO: Found elm 0.19.1
  INFO: Found elm-format at /.*/tests/bin_elmformat/elm-format (re)
  INFO: Found elm-format 0\.8\.[0-9]+ (re)
  INFO: Cleaning ./elm-stuff before upgrading
  INFO: Converting elm-package.json -> elm.json
  INFO: Detected a package project (this project has exposed modules)
  INFO: Detected 'BSD3' license, which is not a valid SPDX license identifier; converting to 'BSD-3-Clause'
  INFO: Switching from elm-lang/core (deprecated) to elm/core
  INFO: Installing latest version of elm/core
  It is already installed!
  INFO: Upgrading *.elm files in src/
  
  
  SUCCESS! Your project's dependencies and code have been upgraded.
  However, your project may not yet compile due to API changes in your
  dependencies.
  
  See <https://github.com/elm/compiler/blob/master/upgrade-docs/0.19.md>
  and the documentation for your dependencies for more information.
  
  Here are some common upgrade steps that you will need to do manually:
  
  - elm/core
    - [ ] Replace uses of toString with String.fromInt, String.fromFloat, or Debug.toString as appropriate
  

The transformed project should look like:

  $ git add -N .
  $ git status --short elm-package.json
  D  elm-package.json
  $ git diff elm.json
  diff --git a/elm.json b/elm.json
  new file mode 100644
  index 0000000..[0-9a-f]* (re)
  --- /dev/null
  +++ b/elm.json
  @@ -0,0 +1,15 @@
  +{
  +    "type": "package",
  +    "name": "avh4/project",
  +    "summary": "helpful summary of your project, less than 80 characters",
  +    "license": "BSD-3-Clause",
  +    "version": "1.0.0",
  +    "exposed-modules": [
  +        "CoolData"
  +    ],
  +    "elm-version": "0.19.0 <= v < 0.20.0",
  +    "dependencies": {
  +        "elm/core": "1.0.0 <= v < 2.0.0"
  +    },
  +    "test-dependencies": {}
  +}
  \ No newline at end of file
