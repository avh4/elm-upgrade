
1. Make a branch for the new release
1. `npm version <new version>` (creates the tag)
1. Push the new tag `git push origin v<new version>`
1. Wait for the tag to pass CI <https://travis-ci.org/avh4/elm-upgrade>
1. Make sure you have the tag checked out, and `npm publish`
1. Add the helper dist tags `npm dist-tag add elm-upgrade@<new version> elm0.19.0`
