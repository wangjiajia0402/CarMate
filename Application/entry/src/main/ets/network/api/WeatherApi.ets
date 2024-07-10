import http from '@ohos.net.http';
const key = '37e7c53502784a6986089a8af4dac2ab'

// 实时天气
export function getNowWeather(location: number): Promise<http.HttpResponse> {
  let httpRequest = http.createHttp();
  return httpRequest.request(
    "https://devapi.qweather.com/v7/weather/now?location=" + location + "&key=" + key,
    {
      method: http.RequestMethod.GET,
      expectDataType: http.HttpDataType.OBJECT,
    });
}

// 7日天气
export function get7dWeather(location: number): Promise<http.HttpResponse> {
  let httpRequest = http.createHttp();
  return httpRequest.request(
    "https://devapi.qweather.com/v7/weather/7d?location=" + location + "&key=" + key,
    {
      method: http.RequestMethod.GET,
      expectDataType: http.HttpDataType.OBJECT,
    });
}

// 24小时天气预报
export function get24hWeather(location: number): Promise<http.HttpResponse> {
  let httpRequest = http.createHttp();
  return httpRequest.request(
    "https://devapi.qweather.com/v7/weather/24h?location=" + location + "&key=" + key,
    {
      method: http.RequestMethod.GET,
      expectDataType: http.HttpDataType.OBJECT,
    });
}