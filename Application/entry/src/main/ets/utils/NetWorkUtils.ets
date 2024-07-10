import http from '@ohos.net.http';
import Log from './Logger';

type NetRepCallback=(reqCode: number, responseCode: number, ret: string)=>void;

export class NetWorkItem {
  private url: string = undefined;
  private data: Map<string, any> = new Map();
  private code: number = 0;

  setTargetUrl(url: string) {
    this.url = url;
  }

  getTargetUrl() {
    return this.url;
  }

  setReqCode(reqCode: number) {
    this.code = reqCode;
  }

  getReqCode() {
    return this.code;
  }

  addItem(key: string, value: any) {
    this.data.set(key, value);
  }

  getItem(key: string) {
    return this.data.get(key);
  }

  isEffective() {
    return this.url != undefined && this.url.length > 0 && this.data.size > 0;
  }

  toReqData(): string {
    if (this.data.size <= 0) {
      return undefined;
    }
    let json = {};
    this.data.forEach((v, k) => {
      json[k] = v;
    });
    Log.debug("NetWorkItem", "" + json);
    return JSON.stringify(json);
  }
}

class NetWorkCrl {
  private officialUrl: string = 'https://zmcalender-api.colaapp.cn';
  private testUrl: string = 'http://61.152.66.114:8055';

  sendRequest(req: NetWorkItem, callback: NetRepCallback): boolean {
    if (!req.isEffective()) {
      return false;
    }
    let httpReq = http.createHttp();
    httpReq.request(this.testUrl + req.getTargetUrl(), {
      method: http.RequestMethod.POST,
      header: {
        'Content-Type': 'application/json'
      },
      extraData: req.toReqData()
    }, (err, data) => {
      if (!err) {
        Log.debug("NetWorkCrl", JSON.stringify(data.result));
        callback(req.getReqCode(), data.responseCode, JSON.stringify(data.result));
      }
      httpReq.destroy();
    });
    return true;
  }
}

export default new NetWorkCrl();