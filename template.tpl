___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Log To Console",
  "categories": [
    "UTILITY"
  ],
  "brand": {
    "id": "mbaersch",
    "displayName": "mbaersch",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAMAAABEpIrGAAAAilBMVEUAAAAKCs8KCs8KCs8KCs8LC88KCs8KCs8MDNALC9AKCs8KCs8KCs8KCs8LC88KCs8KCs8KCs8LC88KCs8KCs8KCs8NDdAKCs8KCs8PD9AKCs8KCs8LC88KCs8KCs8LC88LC88LC88MDNAKCs8KCs8LC88KCs8KCs8KCs8KCs8LC88NDdAMDM8KCs+4VWhtAAAALXRSTlMA4PqrzUU9bQ8F9SET85js0cJ8ak8vKhi2HpJdS+fk2MiJJKGfhHVnYFtZCos+ZXjrAAABV0lEQVQ4y7WR6XKDIBhFAUUQt2jUqDFJs2+97/96BUmDTeLPnhmH73rPMILEsTh7ChrlnSPyTnXAiEP1UoffAJJNmvZ8m34lANL7uN/5ABXtb2wFBTY710c6d3L4DnGqzSqPDDQa9Uk/TPMEYPNh5MnTCH2owJ5D99qohxAo+OEwnYDeqgUGCpu4QmrWmmFrTVJaQRDL0W6WYiWJJZ6ZfhY/ovTNFvc1hLvMnLHcHa8EiwlH0hJHOw4yw4V0yMkkHjz9dO7Fcq5Zuizgkwyle0GhoS4HAAGC/xYabKeFEpk5ybTQ6fICOi1QFCRm6KeECqjNbeXhZyH08KUrDpSfhRLg1lsvPgmLtdlAE2Xw43ch9sFqO96YMZzw7G/kwZVhw83QzDTNcIe6v45+MwPbRy5HewW2JCMqCqhc8EqPXOQKoJz8QRYraFiWMbOuCklekaLBg2ZU/wAgLC75OSFz9AAAAABJRU5ErkJggg\u003d\u003d"
  },
  "description": "Enter one or multiple objects for logging. The tag creates one or multiple log entries from the contents in the browser`s console.",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "grpCnt",
    "displayName": "Log content",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "SIMPLE_TABLE",
        "name": "logContents",
        "displayName": "",
        "simpleTableColumns": [
          {
            "defaultValue": "",
            "displayName": "Add at least one item to log. All values defined here will appear in the browser´s console.",
            "name": "col",
            "type": "TEXT"
          }
        ],
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "grpFormat",
    "displayName": "Log format",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "SELECT",
        "name": "logFormat",
        "displayName": "Define if multiple values should lead to multiple log entries (\"separated\") or a consolidated single log with all values as an array or string",
        "macrosInSelect": false,
        "selectItems": [
          {
            "value": "separated",
            "displayValue": "separated"
          },
          {
            "value": "array",
            "displayValue": "array"
          },
          {
            "value": "string",
            "displayValue": "string"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "string"
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "grpOptions",
    "displayName": "Options",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "CHECKBOX",
        "name": "onlyDebug",
        "checkboxText": "Log in debug mode only",
        "simpleValueType": true
      },
      {
        "type": "TEXT",
        "name": "LogColor",
        "displayName": "Text color (optional)",
        "simpleValueType": true,
        "help": "Add a valid HTML color code like \"#ff0000\", \"red\" or leave blank",
        "enablingConditions": [
          {
            "paramName": "logFormat",
            "paramValue": "string",
            "type": "EQUALS"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "LogColorBck",
        "displayName": "Background color (optional)",
        "simpleValueType": true,
        "help": "Add a valid HTML color code like \"#fff\", \"white\" or leave blank",
        "enablingConditions": [
          {
            "paramName": "logFormat",
            "paramValue": "string",
            "type": "EQUALS"
          }
        ]
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const cnt = data.logContents;
let doLog = cnt && ((data.onlyDebug !== true) || require("getContainerVersion")().debugMode === true);

if (doLog) {
  const log = require('logToConsole');
  if (data.logFormat === "separated") {
    cnt.forEach(x=>(
      log(x.col)
    ));
  } else if (data.logFormat === "string") {
    let scnt = cnt.reduce((x, y)=>(x += y.col + " "), "");
    let logCss;
    if (data.LogColor) logCss = 'color:'+data.LogColor+";";
    if (data.LogColorBck) logCss += 'background:'+data.LogColorBck;
    if (logCss)
      log("%c" + scnt, logCss);
    else
      log(scnt);
  } else {
    log(cnt.map(x=>x.col));
  }
}

data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "all"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_container_data",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 7.9.2024, 23:23:31


