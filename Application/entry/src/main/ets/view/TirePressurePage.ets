import { TyrePsiCard } from '../view/TyrePsiCard'

@Component
export struct TirePressurePage {
  build() {
    Stack() {
      Image($r('app.media.car'))
        .width("100%")
        .height("85%")
        .objectFit(ImageFit.Contain)
      TyrePsiCard({ x: 15, y: 80, boardColor: Color.Blue })
      TyrePsiCard({ x: 225, y: 80, boardColor: Color.Blue })
      TyrePsiCard({ x: 15, y: 300, boardColor: Color.Blue, isBottomTwoTyre: false })
      TyrePsiCard({ x: 225, y: 300, isBottomTwoTyre: false })
    }
    .width("100%")
    .height("100%")
  }
}