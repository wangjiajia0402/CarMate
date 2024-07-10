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
}).then(AMap => {
    AMapIns = AMap;
    hwMap = new AMap.Map("map", {
        viewMode: '2d', // 默认使用2d地图
        zoom: 16, // 地图的默认缩放等级
        center: [121.658994, 31.268792]
    })
    const position = new AMap.LngLat(121.499718, 31.239703); //Marker经纬度

    //地图选点的标记
    nowMark = new AMap.Marker({
        position,
        content: '<i class="iconfont icon-a-dingwei4"></i>',
        offset: new AMap.Pixel(0, 15)
    })
    hwMap.add(nowMark)

    // 地图选点的文字提示
    nowLayer = new AMap.Marker({
        position,
        content: '<div class="posi">位置信息获取中</div>',
        offset: new AMap.Pixel(-13, -40)
    })
    hwMap.add(nowLayer)

    // 对地图的移动事件进行监听
    const handleCenterChange = _.debounce((curCenter) => {
        // 解码做标点的地址信息
        siteServer.getAddress([curCenter.lng, curCenter.lat], function (status, result) {
            if (status === 'complete' && result.info === 'OK') {
                console.log('result', result)
                const {city,provience,district,township} = result.regeocode.addressComponent;
                const adress = result.regeocode.formattedAddress.replace(`${provience}${city}${district}${township}`, '')
                nowLayer.setContent(`<div class="posi">${adress}</div>`); //修改内容
                nowLayer.setPosition(curCenter); //修改位置
                //使用h5port把解码后的地址信息发送给ets
                //传递出去的值是字符串的形式
                //在本项目当中我们约定we
                h5port.postMessage(JSON.stringify({
                    type: 'passLocation',
                    payload: {
                        name: adress,
                        location: curCenter.lng + ',' + curCenter.lat
                    }
                }))
            }
        })
    }, 300)

    hwMap.on('mapmove', () => {
        const curCenter = hwMap.getCenter(); // 获取地图最新的中心点坐标
        // 处理选点标记
        nowMark.setPosition(curCenter)
        handleCenterChange(curCenter);
    })

    // 解码
    AMap.plugin('AMap.Geocoder', () => {
        siteServer = new AMap.Geocoder({
            city: '020',
            extensions: 'base'
        })
    })
})

const handleMessage = (data) => {
    console.log('从ets发送过来的数据', data);
}


//响应postMessage事件
window.addEventListener('message', function (event) {
    console.log('与应用测建立了通讯');
    if (event.data === '__init_port__') {
        h5port = event.ports[0]
        h5port.onmessage = handleMessage
    }
})