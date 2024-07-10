//初始化调试工具
// const vConsole = new window.VConsole();
// setTimeout(()=>{
//     vConsole.setSwitchPosition(0,500)
// },300)

//设置地图的安全密钥
window._AMapSecurityConfig = {
    securityJsCode: "7e6c58b7b512511c64222b8939843369"
}
var hwMap;
var AMapIns;
var nowMark;
var nowLayer;
var siteServer;
var h5port;


AMapLoader.load({
    key: "c43eea0516110504b533b511584a3a83",
    version: "2.0"
}).then(async AMap => {
    AMapIns = AMap;
    hwMap = new AMap.Map("map", {
        viewMode: '2d', // 默认使用2d地图
        zoom: 16, // 地图的默认缩放等级
        center: [121.658994, 31.268792]
    })

})

const handleMessage = (event) => {
    console.log('从ets发送过来的数据', event.data);
    const {type,payload} = JSON.parse(event.data);
    if (type === 'zoom-') {
        hwMap.zoomOut();
        hwMap.resize();
    }
    if (type === 'zoom+') {
        hwMap.zoomIn();
        hwMap.resize();
    }
    if (type === 'drawLine') {
        const startLoc = payload.startLocationInfo.location.split(',');
        const endLoc = payload.endLocationInfo.location.split(',');
        AMapIns.plugin('AMap.Driving', () => {
            const driving = new AMapIns.Driving({
                map: hwMap
            })
            driving.search(startLoc, endLoc, function (staus, result) {

            })
        })
    }
}


//响应postMessage事件
window.addEventListener('message', function (event) {
    console.log('与应用测建立了通讯');
    if (event.data === '__init_port__') {
        h5port = event.ports[0]
        h5port.onmessage = handleMessage
        h5port.postMessage(JSON.stringify({ type: 'webready' }))
    }
})