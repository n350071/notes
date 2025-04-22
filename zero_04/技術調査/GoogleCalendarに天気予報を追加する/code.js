// 個人的なノートへのリンクID = 4a5cc744f5;
// Google Apps Script: 天気予報をGoogleカレンダーに自動登録（Yahoo!天気、今日〜1週間対応）＋Slack通知
const CALENDAR_ID = 'hoge@group.calendar.google.com';
const SLACK_WEBHOOK_URL = 'https://hooks.slack.com/services/hoge/fuga/mogera';

function updateHybridWeatherForecast() {
  Logger.log('==== ハイブリッド天気予報の登録を開始 ====');
  sendSlackNotification(`🟡 天気予報の登録が開始します`);
  const events = [];

  events.push(...fetchTodayTomorrowFromYahoo());
  events.push(...fetchWeeklyFromYahoo());

  Logger.log(`合計 ${events.length} 件の天気イベントを処理します`);

  events.forEach(event => {
    registerWeatherEvent(event.date, event.title, event.description);
  });

  Logger.log('==== ハイブリッド天気予報の登録が完了 ====');
  sendSlackNotification(`✅ 天気予報の登録が完了しました（${events.length}件）`);
}

function fetchTodayTomorrowFromYahoo() {
  Logger.log('Yahoo!天気の今日・明日の予報を取得開始');
  const url = 'https://weather.yahoo.co.jp/weather/jp/40/8210.html';

  try {
    const html = UrlFetchApp.fetch(url).getContentText('utf-8');
    const dayBlocks = [...html.matchAll(/<div>\s*<p class="date">([\s\S]*?)<\/dl>\s*<\/div>/g)];
    const today = new Date(); today.setHours(0, 0, 0, 0);
    const results = [];

    for (let i = 0; i < dayBlocks.length; i++) {
      const block = dayBlocks[i][0];
      const date = new Date(today); date.setDate(today.getDate() + i);

      const weatherMatch = block.match(/<p class="pict">[\s\S]*?alt="([^"]+)"/);
      const weather = weatherMatch ? weatherMatch[1].trim() : '';

      const highMatch = block.match(/<li class="high"><em>(-?\d+)<\/em>/);
      const lowMatch = block.match(/<li class="low"><em>(-?\d+)<\/em>/);
      const high = highMatch ? highMatch[1] : '';
      const low = lowMatch ? lowMatch[1] : '';

      const rainMatch = [...block.matchAll(/<tr class="precip">[\s\S]*?<td>([^<]*)<\/td>/g)].flat();
      const rainList = rainMatch.slice(1, 5).map(r => r.replace(/[％%]/g, '').replace('---', '').trim());
      const rain = Math.max(...rainList.map(r => parseInt(r || '0')));

      const title = generateWeatherTitle(weather, rain, low, high);
      const description = `出典: Yahoo!天気\n天気: ${weather}\n最高気温: ${high}℃\n最低気温: ${low}℃\n降水確率(時間帯別): ${rainList.join(', ')}%`;

      results.push({ date, title, description });
    }
    return results;
  } catch (e) {
    Logger.log(`Yahoo!天気取得でエラー: ${e.message}`);
    sendSlackNotification(`⚠️ Yahoo!天気取得でエラー: ${e.message}`);
    return [];
  }
}

function fetchWeeklyFromYahoo() {
  Logger.log('Yahoo!天気の週間予報を取得開始');
  const url = 'https://weather.yahoo.co.jp/weather/jp/40/8210.html';

  try {
    const html = UrlFetchApp.fetch(url).getContentText('utf-8');
    const tableMatch = html.match(/<table[^>]*class="yjw_table"[^>]*>([\s\S]*?)<\/table>/);
    if (!tableMatch) {
      Logger.log('週間天気テーブルが見つかりません');
      return [];
    }
    const tableHtml = tableMatch[1];

    const weatherRow = tableHtml.match(/<tr[^>]*>\s*<td[^>]*>.*?天気.*?<\/td>(.*?)<\/tr>/s);
    const tempRow = tableHtml.match(/<tr[^>]*>\s*<td[^>]*>.*?気温.*?<\/td>(.*?)<\/tr>/s);
    const rainRow = tableHtml.match(/<tr[^>]*>\s*<td[^>]*>.*?降水.*?<\/td>(.*?)<\/tr>/s);

    if (!weatherRow || !tempRow || !rainRow) {
      Logger.log('週間天気行のパースに失敗');
      return [];
    }

    const weatherCells = [...weatherRow[1].matchAll(/<small>([^<]+)<\/small>/g)];
    const tempCells = [...tempRow[1].matchAll(/<font[^>]*>(-?\d+)<\/font>/g)];
    const rainCells = [...rainRow[1].matchAll(/<small>(\d+)<\/small>/g)];

    const today = new Date(); today.setHours(0, 0, 0, 0);
    const results = [];
    const days = Math.min(weatherCells.length, Math.floor(tempCells.length / 2), rainCells.length);

    for (let i = 0; i < days; i++) {
      const date = new Date(today); date.setDate(today.getDate() + i + 2); // 3日目以降
      const weather = weatherCells[i][1].trim();
      const high = tempCells[i * 2][1];
      const low = tempCells[i * 2 + 1][1];
      const rain = rainCells[i][1];

      const title = generateWeatherTitle(weather, rain, low, high);
      const description = `出典: Yahoo!天気\n天気: ${weather}\n最高気温: ${high}℃\n最低気温: ${low}℃\n降水確率: ${rain}%`;

      results.push({ date, title, description });
    }
    return results;
  } catch (e) {
    Logger.log(`Yahoo!週間天気取得でエラー: ${e.message}`);
    sendSlackNotification(`⚠️ Yahoo!週間天気取得でエラー: ${e.message}`);
    return [];
  }
}

function registerWeatherEvent(date, title, description = '') {
  const calendar = CalendarApp.getCalendarById(CALENDAR_ID);
  const events = calendar.getEventsForDay(date);
  events.forEach(event => event.deleteEvent());
  calendar.createAllDayEvent(title, date, { description });
}

function generateWeatherTitle(weatherText, rain, tempMin, tempMax) {
  const clean = weatherText.replace(/\s+/g, '');
  let title = '', timeNote = '', localizedNote = '';

  if (clean.includes('のち')) {
    const [first, second] = clean.split('のち');
    title = `${first}→${second}`;
  } else if (clean.includes('時々')) {
    const [first, second] = clean.split('時々');
    title = `${first}／${second}`;
  } else if (clean.includes('一時')) {
    const [first, second] = clean.split('一時');
    title = `${first}＃${second}`;
  } else {
    title = clean;
  }

  if (clean.includes('所により')) {
    const match = clean.match(/所により(.+?)$/);
    localizedNote = match ? `＋所により${match[1]}` : '＋所により';
  }

  const times = ['朝', '昼', '昼過ぎ', '夕方', '夜', '夜遅く', '夜のはじめ頃', '朝のうち'];
  for (const time of times) {
    if (clean.includes(time)) {
      timeNote = `(${time})`;
      break;
    }
  }

  const tempPart = (tempMin && tempMax) ? ` ${tempMax}/${tempMin}℃` : '';
  const rainPart = rain ? ` (${rain}%)` : '';

  return `${title}${localizedNote ? ' ' + localizedNote : ''}${timeNote ? ' ' + timeNote : ''}${rainPart}${tempPart}`.trim();
}

function sendSlackNotification(message) {
  const payload = JSON.stringify({ text: message });
  const options = {
    method: 'post',
    contentType: 'application/json',
    payload: payload
  };
  try {
    UrlFetchApp.fetch(SLACK_WEBHOOK_URL, options);
    Logger.log('Slack通知を送信しました');
  } catch (e) {
    Logger.log(`Slack通知の送信に失敗しました: ${e.message}`);
  }
}
