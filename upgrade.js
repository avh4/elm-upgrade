#!/usr/bin/env node

var fs = require("fs-extra");
var childProcess = require("child_process");
var which = require("which");
var semver = require("semver");
var path = require("path");

var packageHost = "https://package.elm-lang.org";

var packageTransformations = {
  "NoRedInk/elm-decode-pipeline": [
    {
      action: "installPackage",
      packageName: "NoRedInk/elm-json-decode-pipeline"
    }
  ],
  "elm-community/elm-test": [
    { action: "installPackage", packageName: "elm-explorations/test" }
  ],
  "elm-lang/animation-frame": [
    { action: "installPackage", packageName: "elm/browser" }
  ],
  "elm-lang/core": [{ action: "installPackage", packageName: "elm/core" }],
  "elm-lang/html": [{ action: "installPackage", packageName: "elm/html" }],
  "elm-lang/http": [{ action: "installPackage", packageName: "elm/http" }],
  "elm-lang/navigation": [
    { action: "installPackage", packageName: "elm/browser" }
  ],
  "elm-lang/svg": [{ action: "installPackage", packageName: "elm/svg" }],
  "elm-lang/virtual-dom": [
    { action: "installPackage", packageName: "elm/virtual-dom" }
  ],
  "elm-tools/parser": [{ action: "installPackage", packageName: "elm/parser" }],
  "evancz/elm-markdown": [
    { action: "installPackage", packageName: "elm-explorations/markdown" }
  ],
  "evancz/url-parser": [{ action: "installPackage", packageName: "elm/url" }],
  "mgold/elm-random-pcg": [
    { action: "installPackage", packageName: "elm/random" }
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
    { action: "installPackage", packageName: "mpizenberg/elm-pointer-events" }
  ],
  "mpizenberg/elm-touch-events": [
    { action: "installPackage", packageName: "mpizenberg/elm-pointer-events" }
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
    { action: "installPackage", packageName: "dillonkearns/elm-graphql" }
  ],
  "BrianHicks/elm-benchmark": [
    { action: "installPackage", packageName: "elm-explorations/benchmark" }
  ]
};

var packageSplits = {
  "elm-lang/core": {
    "elm/json": ["Json.Decode", "Json.Encode"],
    "elm/random": ["Random"],
    "elm/time": ["Time", "Date"],
    "elm/regex": ["Regex"]
  }
};

var logHandle = null;

function exit(status) {
  if (logHandle) {
    fs.closeSync(logHandle);
  }
  process.exit(status);
}

function logFile(message) {
  if (logHandle == null) {
    var timestamp = new Date().toISOString();
    logHandle = fs.openSync("./elm-upgrade-" + timestamp + ".log", "ax");
  }
  fs.writeSync(logHandle, message);
}

function logMessage(message) {
  process.stdout.write(message);
  logFile(message);
}

function logErrorMessage(message) {
  process.stderr.write(message);
  logFile(message);
}

function logInfo(message) {
  logMessage("INFO: " + message + "\n");
}

function logWarning(message) {
  logMessage("WARNING: " + message + "\n");
}

function logError(message) {
  logErrorMessage("ERROR: " + message + "\n");
}

function howToInstallElm() {
  return "Install Elm here https://guide.elm-lang.org/get_started.html#install\n";
}

function howToInstallElmFormat() {
  return "You can download Elm format here https://github.com/avh4/elm-format#installation-\n";
}

function displayHintForNonUpgradedPackage(packageName) {
  logWarning(`${packageName} has not been upgraded to 0.19 yet!`);
}

function displaySuccessMessage(packagesRequiringUpgrade) {
  logMessage(
    "SUCCESS! Your project's dependencies and code have been upgraded.\n" +
      "However, your project may not yet compile due to API changes in your\n" +
      "dependencies.\n\n" +
      "See <https://github.com/elm/compiler/blob/master/upgrade-docs/0.19.md>\n" +
      "and the documentation for your dependencies for more information.\n\n"
  );

  if (packagesRequiringUpgrade.length > 0) {
    logMessage(
      // "WARNING! " +
      //   packagesRequiringUpgrade.length +
      //   " of your dependencies have not yet been upgraded to\n" +
      //   "support Elm 0.19. You can create an issue to request the packages be\n" +
      //   "upgraded here:\n"
      "WARNING! " +
        packagesRequiringUpgrade.length +
        " of your dependencies have not yet been upgraded to\n" +
        "support Elm 0.19.\n"
    );
    packagesRequiringUpgrade.forEach(function(packageName) {
      logMessage(
        // "  - https://github.com/" + packageName + "/issues\n"
        "  - https://github.com/" + packageName + "\n"
      );
    });
    logMessage("\n");
  }
}
/*
  Locate a binary based on name, if not found, error out with message
Provide binFolder in order to look there first
*/
function findBinary(binFolder, name, message, extraInfo) {
  var binary = null;

  // first look in binFolder
  try {
    binary = which.sync(name, { path: binFolder });
  } catch (e) {}

  // then just look all over path
  if (binary === null) {
    try {
      binary = which.sync(name);
    } catch (e) {
      logError(message);
      logErrorMessage(extraInfo);
      exit(1);
    }
  }

  logInfo("Found " + name + " at " + binary);
  return binary;
}

function modifyElmJsonSync(transform) {
  var elmJson = JSON.parse(fs.readFileSync("elm.json", "utf8"));
  elmJson = transform(elmJson);
  saveElmJson(elmJson);
}

function saveElmJson(elmPackage) {
  fs.writeFileSync("elm.json", JSON.stringify(elmPackage, null, 4));
}

function findInFiles(roots, patterns) {
  return roots.some(function(root) {
    return fs.readdirSync(root).some(function(file) {
      var filename = path.join(root, file);
      if (file.slice(-4) === ".elm") {
        var contents = fs.readFileSync(filename, "utf8");
        return patterns.some(function(pattern) {
          return contents.match(pattern);
        });
      } else if (fs.statSync(filename).isDirectory()) {
        return findInFiles([filename], patterns);
      } else {
        return false;
      }
    });
  });
}

function main(knownPackages) {
  var supportedPackages = {};
  knownPackages.forEach(function(packageInfo) {
    supportedPackages[packageInfo.name] = packageInfo.versions.slice(-1)[0];
  });

  function supportsElm0_19(packageName) {
    return !!supportedPackages[packageName];
  }

  function latestVersion(packageName) {
    return supportedPackages[packageName];
  }

  var localBinPath = "./node_modules/.bin/";
  var localFindBinary = findBinary.bind(null, localBinPath);

  var elm = localFindBinary(
    "elm",
    "elm was not found on your PATH.  Make sure you have Elm 0.19 installed.",
    howToInstallElm()
  );

  var elmUsage = childProcess.execFileSync(elm, ["--version"]);
  var elmVersion = elmUsage.toString().split("\n")[0];
  if (!elmVersion.match(/^0\.19\./)) {
    logErrorMessage(
      "ERROR: Elm 0.19 required, but found " +
        elmVersion +
        "\n" +
        howToInstallElm()
    );
    exit(1);
  }
  logInfo("Found elm " + elmVersion);

  var elmFormat = localFindBinary(
    "elm-format",
    "elm-format was not found on your PATH.  Make sure you have elm-format installed.",
    howToInstallElmFormat()
  );

  var elmFormatUsage = childProcess.execFileSync(elmFormat);
  var elmFormatVersion = elmFormatUsage
    .toString()
    .split("\n")[0]
    .trim()
    .split(" ")[1];
  if (semver.lt(elmFormatVersion, "0.8.0")) {
    logError("elm-format >= 0.8.0 required, but found " + elmFormatVersion);
    logErrorMessage(howToInstallElmFormat());
    exit(1);
  }
  logInfo("Found elm-format " + elmFormatVersion);

  function installPackage(name) {
    try {
      childProcess.execFileSync(elm, ["install", name], {
        stdio: "inherit"
      });
    } catch (e) {
      logWarning(`Failed to upgrade ${name}!`);
    }
  }

  if (fs.existsSync("elm.json")) {
    var elmJson = JSON.parse(fs.readFileSync("elm.json", "utf8"));
    var isPackage = elmJson.type == "package";

    if (isPackage) {
      logMessage(
        "\n" +
          "***\n" +
          "*** ./elm.json already exists.\n" +
          "*** It looks like this project has already been upgraded to Elm 0.19.\n" +
          "*** Since this is a package project, you should keep the version bounds\n" +
          "*** for your dependencies as wide as possible.\n" +
          "***\n" +
          "\n\n"
      );
      logInfo("Checking if all your dependencies support Elm 0.19...");

      var foundBadPackage = false;
      var packages = Object.keys(elmJson.dependencies);
      packages.forEach(function(packageName) {
        var latestVersion_ = latestVersion(packageName);
        if (!latestVersion_) {
          foundBadPackage = true;
          displayHintForNonUpgradedPackage(packageName);
        }
      });

      if (!foundBadPackage) {
        logMessage(
          "\n\n" + "SUCCESS! Your project's dependencies look good.\n\n"
        );
      }

      exit(0);
    } else {
      logMessage(
        "\n" +
          "***\n" +
          "*** ./elm.json already exists.\n" +
          "*** It looks like this project has already been upgraded to Elm 0.19.\n" +
          "*** Would you like me to upgrade your project's dependencies?\n" +
          "***\n" +
          "\n"
      );
      var prompt = require("syncprompt");
      var yn = require("yn");
      var proceed = yn(prompt("[Y/n]: "));
      logMessage("\n");

      if (proceed) {
        var packages = Object.keys(elmJson.dependencies.direct);
        packages.forEach(function(packageName) {
          var currentVersion = elmJson.dependencies.direct[packageName];
          var latestVersion_ = latestVersion(packageName);
          if (!latestVersion_) {
            displayHintForNonUpgradedPackage(packageName);
          } else if (semver.lt(currentVersion, latestVersion_)) {
            logInfo("Installing latest version of " + packageName);
            modifyElmJsonSync(function(elmJson) {
              delete elmJson.dependencies.direct[packageName];
              return elmJson;
            });
            installPackage(packageName);
          }
        });

        logMessage(
          "\n\n" +
            "SUCCESS! Your project's dependencies have been upgraded.\n" +
            "However, your project may not yet compile due to API changes in your\n" +
            "dependencies.\n\n"
        );

        exit(0);
      } else {
        exit(0);
      }
    }
    return;
  }

  if (!fs.existsSync("elm-package.json")) {
    logError(
      "You must run the upgrade from a folder containing elm-package.json"
    );
    exit(1);
  }

  // TODO: Warning and prompt if git is not being used
  // TODO: Error if git workspace is dirty

  var elmPackage = JSON.parse(fs.readFileSync("elm-package.json", "utf8"));

  if (!elmPackage["elm-version"].startsWith("0.18.")) {
    logError(
      "This is not an Elm 0.18 project.  Current project uses Elm " +
        elmPackage["elm-version"]
    );
    exit(1);
  }

  logInfo("Cleaning ./elm-stuff before upgrading");
  fs.removeSync("elm-stuff");

  var packageName = elmPackage["repository"].match(
    /^https:\/\/github.com\/([^/]*\/[^/]*)\.git$/
  )[1];
  // TODO: Error if packageName doesn't parse

  logInfo("Converting elm-package.json -> elm.json");

  var isPackage = elmPackage["exposed-modules"].length > 0;

  var elmJson;
  if (isPackage) {
    logInfo("Detected a package project (this project has exposed modules)");

    if (elmPackage["license"] === "BSD3") {
      logInfo(
        "Detected 'BSD3' license, which is not a valid SPDX license identifier; converting to 'BSD-3-Clause'"
      );
      elmPackage["license"] = "BSD-3-Clause";
    }

    elmJson = {
      type: "package",
      name: packageName,
      summary: elmPackage["summary"],
      license: elmPackage["license"],
      version: elmPackage["version"],
      "exposed-modules": elmPackage["exposed-modules"],
      "elm-version": "0.19.0 <= v < 0.20.0",
      dependencies: {
        "elm/core": "1.0.0 <= v < 2.0.0"
      },
      "test-dependencies": {}
    };
  } else {
    logInfo(
      "Detected an application project (this project has no exposed modules)"
    );
    elmJson = {
      type: "application",
      "source-directories": elmPackage["source-directories"],
      "elm-version": "0.19.0",
      dependencies: {
        direct: {
          "elm/core": "1.0.0"
        },
        indirect: {
          "elm/json": "1.0.0"
        }
      },
      "test-dependencies": {
        direct: {},
        indirect: {}
      }
    };
  }
  saveElmJson(elmJson);

  var packagesToInstall = Object.keys(elmPackage["dependencies"]);

  var packagesRequiringUpgrade = [];

  packagesToInstall.forEach(function(packageName) {
    var oldPackageName = packageName;
    var actions = packageTransformations[packageName] || [
      { action: "keepPackage", packageName: packageName }
    ];
    actions.forEach(function(action) {
      switch (action.action) {
        case "installPackage":
          var newPackageName = action.packageName;
          logInfo(
            "Switching from " +
              packageName +
              " (deprecated) to " +
              newPackageName
          );

          if (!supportsElm0_19(newPackageName)) {
            displayHintForNonUpgradedPackage(newPackageName);
            if (isPackage) {
              // TODO: not tested
              packagesRequiringUpgrade[newPackageName] =
                elmPackage.dependencies[oldPackageName];
            } else {
              packagesRequiringUpgrade[
                newPackageName
              ] = elmPackage.dependencies[oldPackageName].split(" ")[0];
            }
            return;
          }

          logInfo("Installing latest version of " + newPackageName);
          installPackage(newPackageName);
          break;

        case "keepPackage":
          var newPackageName = action.packageName;
          if (!supportsElm0_19(newPackageName)) {
            displayHintForNonUpgradedPackage(newPackageName);
            if (isPackage) {
              // TODO: not tested
              packagesRequiringUpgrade[newPackageName] =
                elmPackage.dependencies[oldPackageName];
            } else {
              packagesRequiringUpgrade[
                newPackageName
              ] = elmPackage.dependencies[oldPackageName].split(" ")[0];
            }
            return;
          }

          logInfo("Installing latest version of " + newPackageName);
          installPackage(newPackageName);
          break;

        default:
          throw "ERROR: Unexpected action: " + JSON.stringify(action);
      }
    });

    var packageSplit = packageSplits[oldPackageName];
    if (packageSplit) {
      Object.keys(packageSplit).forEach(function(target) {
        var moduleNames = packageSplit[target];
        for (var i = 0; i < moduleNames.length; i++) {
          var moduleName = moduleNames[i];
          if (
            findInFiles(elmPackage["source-directories"], [
              RegExp("(^|[\n\r])import " + moduleName + "[ \n\r]")
            ])
          ) {
            logInfo(
              "Detected use of " +
                oldPackageName +
                "#" +
                moduleName +
                "; installing " +
                target
            );
            installPackage(target);
            break;
          }
        }
      });
    }
  });

  elmJson = JSON.parse(fs.readFileSync("elm.json", "utf8"));
  Object.keys(packagesRequiringUpgrade).forEach(function(name) {
    if (isPackage) {
      elmJson.dependencies[name] = packagesRequiringUpgrade[name];
    } else {
      elmJson.dependencies.direct[name] = packagesRequiringUpgrade[name];
    }
  });
  saveElmJson(elmJson);

  fs.unlinkSync("elm-package.json");

  // TODO: deal with source-directories for packages

  elmPackage["source-directories"].forEach(function(sourceDir) {
    if (!fs.existsSync(sourceDir)) {
      logWarning(
        "source directory " +
          sourceDir +
          " listed in your elm-package.json does not exist"
      );
    } else {
      logInfo("Upgrading *.elm files in " + sourceDir + "/");
      childProcess.execFileSync(elmFormat, [
        "--upgrade",
        "--yes",
        "--elm-version",
        "0.19",
        sourceDir
      ]);
    }
  });

  logMessage("\n\n");
  displaySuccessMessage(Object.keys(packagesRequiringUpgrade));
}

function init() {
  var got = require("got");
  var caw = require("caw");
  got(packageHost + "/search.json", { agent: caw() })
    .then(function(response) {
      var knownPackages = JSON.parse(response.body);
      main(knownPackages);
    })
    .catch(function(err) {
      console.error(err);
      logError(
        "Unable to connect to " + packageHost + ".  Please try again later."
      );
      exit(1);
    });
}

init();
