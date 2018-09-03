module.exports = {
  "NoRedInk/elm-decode-pipeline": [
    {
      action: "installPackage",
      packageName: "NoRedInk/elm-json-decode-pipeline",
      todos: [
        "Changes uses of Json.Decode.Pipeline.decode to Json.Decode.succeed"
      ]
    }
  ],
  "elm-community/elm-test": [
    { action: "installPackage", packageName: "elm-explorations/test" }
  ],
  "elm-lang/animation-frame": [
    { action: "installPackage", packageName: "elm/browser" }
  ],
  "elm-lang/core": [
    { action: "installPackage", packageName: "elm/core" },
    {
      action: "match",
      condition: {
        type: "usesModule",
        modules: ["Json.Decode", "Json.Encode"]
      },
      ifMet: [{ action: "installPackage", packageName: "elm/json" }]
    },
    {
      action: "match",
      condition: {
        type: "usesModule",
        modules: ["Random"]
      },
      ifMet: [{ action: "installPackage", packageName: "elm/random" }]
    },
    {
      action: "match",
      condition: {
        type: "usesModule",
        modules: ["Time", "Date"]
      },
      ifMet: [{ action: "installPackage", packageName: "elm/time" }]
    },
    {
      action: "match",
      condition: {
        type: "usesModule",
        modules: ["Regex"]
      },
      ifMet: [{ action: "installPackage", packageName: "elm/regex" }]
    }
  ],
  "elm-lang/html": [{ action: "installPackage", packageName: "elm/html" }],
  "elm-lang/http": [{ action: "installPackage", packageName: "elm/http" }],
  "elm-lang/navigation": [
    {
      action: "installPackage",
      packageName: "elm/browser",
      todos: [
        "Make sure to use Browser.application to create your program",
        "Use the Browser.Key passed to your init function in any calls to Browser.Navigation.pushUrl/replaceUrl/back/forward"
      ]
    },
    {
      action: "installPackage",
      packageName: "elm/url",
      todos: ["Changes uses of Navigation.Location to Url.Url"]
    }
  ],
  "elm-lang/svg": [{ action: "installPackage", packageName: "elm/svg" }],
  "elm-lang/window": [
    {
      action: "installPackage",
      packageName: "elm/browser",
      todos: ["Change code using Window.* to use Browser.Events.onResize"]
    }
  ],
  "elm-lang/virtual-dom": [
    { action: "installPackage", packageName: "elm/virtual-dom" }
  ],
  "elm-tools/parser": [{ action: "installPackage", packageName: "elm/parser" }],
  "evancz/elm-markdown": [
    { action: "installPackage", packageName: "elm-explorations/markdown" }
  ],
  "evancz/url-parser": [{ action: "installPackage", packageName: "elm/url" }],
  "mgold/elm-random-pcg": [
    {
      action: "installPackage",
      packageName: "elm/random",
      todos: ["Change references to Random.Pcg.* to Random.*"]
    }
  ],
  "ohanhi/keyboard-extra": [
    { action: "installPackage", packageName: "ohanhi/keyboard" }
  ],
  "thebritican/elm-autocomplete": [
    { action: "installPackage", packageName: "ContaSystemer/elm-menu" }
  ],
  "elm-community/linear-algebra": [
    { action: "installPackage", packageName: "elm-explorations/linear-algebra" }
  ],
  "elm-community/webgl": [
    { action: "installPackage", packageName: "elm-explorations/webgl" }
  ],
  "elm-lang/keyboard": [
    { action: "installPackage", packageName: "elm/browser" }
  ],
  "elm-lang/dom": [{ action: "installPackage", packageName: "elm/browser" }],
  "mpizenberg/elm-mouse-events": [
    {
      action: "installPackage",
      packageName: "mpizenberg/elm-pointer-events",
      todos: [
        "Read the upgrade instructions here: https://github.com/mpizenberg/elm-pointer-events/blob/master/upgrade.md"
      ]
    }
  ],
  "mpizenberg/elm-touch-events": [
    {
      action: "installPackage",
      packageName: "mpizenberg/elm-pointer-events",
      todos: [
        "Read the upgrade instructions here: https://github.com/mpizenberg/elm-pointer-events/blob/master/upgrade.md"
      ]
    }
  ],
  "ryannhg/elm-date-format": [
    { action: "installPackage", packageName: "ryannhg/date-format" }
  ],
  "rtfeldman/hex": [
    { action: "installPackage", packageName: "rtfeldman/elm-hex" }
  ],
  "elm-lang/mouse": [{ action: "installPackage", packageName: "elm/browser" }],
  "avh4/elm-transducers": [
    {
      action: "installPackage",
      packageName: "avh4-experimental/elm-transducers"
    }
  ],
  "dillonkearns/graphqelm": [
    {
      action: "installPackage",
      packageName: "dillonkearns/elm-graphql",
      todos: ["Changes references to Graphqelm.* to Graphql.*"]
    }
  ],
  "BrianHicks/elm-benchmark": [
    { action: "installPackage", packageName: "elm-explorations/benchmark" }
  ]
};
