import network, { NetworkResponse } from '@system.network';

export default class NetworkMonitor {
  onNetworkChange?: (type: string) => void;

  subscribe(options?: {
    success?: (data: NetworkResponse) => void;
    fail?: (data: any, code: number) => void;

  }): void

  subscribe() {
    network.subscribe({
      success: (data) => {
        console.log('success get network type:' + data.type);
        if (this.onNetworkChange) {
          this.onNetworkChange(data.type);
        }
      },
      fail: (data) => {
        console.log('fail get network type:' + data.type)
        if (this.onNetworkChange) {
          this.onNetworkChange(data.type);
        }
      }
    });
  }
}