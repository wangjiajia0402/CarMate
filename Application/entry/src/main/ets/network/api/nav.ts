import $api from './index'

const keyMapKey = '4ffbbcd9ff01bced441bfb75ed9a2917';
const originLocation = '121.473667,31.230525';
const baseData = {
  key: keyMapKey,
  location: originLocation
}

export const getPosByWord = (data) => {
  return $api.get('https://restapi.amap.com/v5/place/around', {
    ...baseData,
    ...data
  })
}
