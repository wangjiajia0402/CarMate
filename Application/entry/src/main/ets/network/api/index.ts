import http from '@ohos.net.http';

const baseUrl = 'http://192.168.1.101:3000';

const requestSelf = async (url: string, method: http.RequestMethod, extraData: any) => {
  const token = ''
  const httpRequest = http.createHttp();
  httpRequest.on('headersReceive', (header) => {
    console.log('header:' + JSON.stringify(header));
  })
  const data: any = await httpRequest.request(
    url.includes('http') ? url : baseUrl + url,
    {
      method,
      header: {
        'Content-Type': 'application/json',
        'Authorization': token || ''
      },
      extraData,
      expectDataType: http.HttpDataType.STRING,
      usingCache: true,
      priority: 1,
    }

  )
  httpRequest.off('headersReceive');
  httpRequest.destroy();
  return JSON.parse(data.result);
}

const $api = {
  post(url, data) {
    return requestSelf(url, http.RequestMethod.POST, data);
  },
  get(url, data) {
    return requestSelf(url, http.RequestMethod.GET, data);
  },
}

export default $api;