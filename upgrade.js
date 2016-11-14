#!/usr/bin/env node

var fs = require('fs-extra');
var child_process = require('child_process');
var which = require('which');

var packagesRequiringUpgrade = [];


function howToInstallElm(){
  return 'Install Elm here https://guide.elm-lang.org/get_started.html#install\n'
}

function howToInstallElmFormat(){
  return 'You can download Elm format here https://github.com/avh4/elm-format#installation-\n'
}

function displayHintForNonUpgradedPackage(packageName){
    process.stdout.write(`WARNING: ${packageName} has not been upgraded to 0.18 yet!\n`);
    packagesRequiringUpgrade.push(packageName);
}

function displaySuccessMessage() {
  process.stdout.write(
    'SUCCESS! Your project\'s dependencies and code have been upgraded.\n'
    + 'However, your project may not yet compile due to API changes in your\n'
    + 'dependencies.\n\n'
    + 'See https://github.com/elm-lang/elm-platform/blob/master/upgrade-docs/0.18.md\n'
    + 'and the documentation for your dependencies for more information.\n\n'
  );

  if (packagesRequiringUpgrade.length > 0) {
    process.stdout.write(
      'WARNING! ' + packagesRequiringUpgrade.length + ' of your dependencies have not yet been upgraded to \n'
      + 'support Elm 0.18. You can create an issue to request the packages be \n'
      + 'upgraded here:\n');
    packagesRequiringUpgrade.forEach(function(packageName) {
      process.stdout.write('  - https://github.com/' + packageName + '/issues\n');
    });
    process.stdout.write('\n');
  }
}

function findBinary(name, message) {
  try {
    var binary = which.sync(name);
    process.stdout.write('INFO: Found ' + name + ' at ' + binary + '\n');
    return binary;
  } catch (e) {
    process.stderr.write(message);
    process.exit(1);
  }
}

function main(knownUpgrades) {
  function hasBeenUpgraded(packageName) {
    return knownUpgrades.indexOf(packageName) > -1;
  }

  function saveFile(elmPackage){
    fs.writeFileSync('elm-package.json', JSON.stringify(elmPackage, null, 4));
  }


  var elm = findBinary(
    'elm',
    'ERROR: elm was not found on your PATH.  Make sure you have Elm 0.18 installed.\n' + howToInstallElm()
  );

  var elmFormat = findBinary('elm-format', 'ERROR: elm-format was not found on your PATH.  Make sure you have elm-format installed.\n' + howToInstallElmFormat());

  var elmUsage = child_process.execFileSync(elm);
  var elmVersion = elmUsage.toString().split('\n')[0].split(' - ')[0].trim();
  if (!elmVersion.match(/^Elm Platform 0\.18\./)) {
    process.stderr.write('ERROR: Elm 0.18 required, but found ' + elmVersion + '\n' + howToInstallElm())
    process.exit(1)
  }
  process.stdout.write('INFO: Found ' + elmVersion + '\n');


  var elmFormatUsage = child_process.execFileSync(elmFormat);
  var elmFormatVersion = elmFormatUsage.toString().split('\n')[0].trim();
  if (!elmFormatVersion.match(/^elm-format-0\.1[678] 0\.5\./)) {
    process.stderr.write('ERROR: elm-format >= 0.5.0-alpha required, but found ' + elmFormatVersion + '\n' + howToInstallElmFormat())
    process.exit(1)
  }
  process.stdout.write('INFO: Found ' + elmFormatVersion + '\n');


  if (!fs.existsSync('elm-package.json')) {
    process.stderr.write('ERROR: You must run the upgrade from a folder containing elm-package.json\n')
    process.exit(1)
  }

  // TODO: Warning and prompt if git is not being used
  // TODO: Error if git workspace is dirty

  process.stdout.write('INFO: Cleaning ./elm-stuff before upgrading\n')
  fs.removeSync('elm-stuff');

  var elmPackage = JSON.parse(fs.readFileSync('elm-package.json', 'utf8'));
  var oldElmPackage = JSON.parse(JSON.stringify(elmPackage));

  if (!elmPackage['elm-version'].startsWith('0.17.')) {
    process.stderr.write('ERROR: This is not an Elm 0.17 project.  Current project uses Elm ' + elmPackage['elm-version'] + '\n');
    process.exit(1);
  }

  process.stdout.write('INFO: Changing elm-package.json#elm-version to "0.18.0 <= v < 0.19.0"\n')
  elmPackage['elm-version'] = '0.18.0 <= v < 0.19.0'
  saveFile(elmPackage);

  process.stdout.write('INFO: Removing all dependencies from elm-package.json to reinstall them\n')
  var oldDeps = elmPackage['dependencies'];
  elmPackage['dependencies'] = {};
  saveFile(elmPackage);

  Object.keys(oldDeps).forEach(function(packageName) {
    if (packageName === 'evancz/elm-http') {
      process.stdout.write('INFO: Switching from evancz/elm-http (deprecated) to elm-lang/http\n');
      packageName = 'elm-lang/http';
    }

    if (!hasBeenUpgraded(packageName)) {
      displayHintForNonUpgradedPackage(packageName);
      return;
    }

    process.stdout.write('INFO: Installing latest version of ' + packageName + '\n');

    try{
      child_process.execFileSync(elm, ['package', 'install', '--yes', packageName]);
    } catch (e){
      process.stdout.write(`Failed to upgrade ${packageName}! Reverting changes..\n`);
      saveFile(oldElmPackage);
    }
  });

  elmPackage['source-directories'].forEach(function(sourceDir) {
    process.stdout.write('INFO: Upgrading *.elm files in ' + sourceDir + '/\n')
    child_process.execFileSync(elmFormat, ['--upgrade', '--yes', '--elm-version', '0.18', sourceDir]);
  })

  process.stdout.write('\n\n');
  displaySuccessMessage();
}

function init(){
  var get = require('simple-get')
  get.concat('http://package.elm-lang.org/new-packages', function(err, res, data){
    if (err) {
      process.stderr.write('ERROR: Unable to connect to http://package.elm-lang.org.  Please try again later.\n');
      process.exit(1);
    }
    var upgradedPackages = JSON.parse(data);
    main(upgradedPackages);
  });

};

init();
