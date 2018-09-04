/**
 * top level variables
 */
var bookURL   = "https://docs.google.com/spreadsheets/*****";
var book      = SpreadsheetApp.openByUrl(bookURL);
/* prodction */
var mainSheet = book.getSheetByName("main");
var logSheet  = book.getSheetByName("log");
/* test*/
//var mainSheet = book.getSheetByName("testMain");
//var logSheet  = book.getSheetByName("testLog");

// channels.history
// https://api.slack.com/methods/channels.history/test
// #home
// https://slack.com/api/channels.history?token=***

/**
 * this get slack.history and paste it to google sheet
 */
function getSlackHist(){
  var slackUrl = "https://slack.com/api/conversations.history?token=***"
  var response = UrlFetchApp.fetch(slackUrl)
  Logger.log(response.getContentText());

  var resJson = JSON.parse(response.getContentText());
  for(i=0; i < resJson.messages.length; i++){
    mainSheet.getRange(i+1, 1).setValue(resJson.messages[i].text);
    mainSheet.getRange(i+1, 2).setValue(resJson.messages[i].ts);
  }
  delSlackAnMessage();
}
// https://slack.com/api/chat.delete?token=***
function delSlackAnMessage(){
  var urlPrefix   = "https://slack.com/api/chat.delete?token=***"
  var urlSafix = "&pretty=1"

  var tsAry = mainSheet.getRange(1, 2, mainSheet.getLastRow()).getValues();
  Logger.log(tsAry.toString());

  for(i=0; i < tsAry.length; i++){
    var url = urlPrefix + tsAry[i] + urlSafix;
    var response = UrlFetchApp.fetch(url, {muteHttpExceptions: true})
    mainSheet.getRange(i+1, 4).setValue(url);
    mainSheet.getRange(i+1, 3).setValue(JSON.parse(response.getContentText()).ok);
  }
  Utilities.sleep(10*1000);

  getSlackHist();
}
