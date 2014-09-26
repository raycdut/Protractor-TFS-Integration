/*jslint node: true */
/*global jasmine */
"use strict";
exports.config = {
    // The address of a running selenium server.
    seleniumAddress: 'http://localhost:4444/wd/hub',

    // Capabilities to be passed to the webdriver instance.
    capabilities: {
        'browserName': 'chrome'
    },

    // Spec patterns are relative to the current working directly when
    // protractor is called.
    specs: ['Tests/*.js'],

    // Options to be passed to Jasmine-node.
    jasmineNodeOpts: {
        showColors: true,
        defaultTimeoutInterval: 30000
    },

    onPrepare: function () {
        console.log('Adding TRX reporter');
        require('protractor-trx-reporter');
        jasmine.getEnv().addReporter(new jasmine.TrxReporter('ProtractorTestResults.trx'));
    },
};
