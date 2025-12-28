import { animationDuration, gradientAngle } from "../pages/Test/Config"

@ComponentV2
export struct SquareButton {
  @Param label: string | Resource | undefined = undefined
  @Param icon: Resource | undefined = undefined
  @Param fontSize: number = 20
  @Param checked: boolean = false
  @Param buttonColor: ResourceColor =  $r('app.color.button')
  @Param buttonColor2: ResourceColor =  $r('app.color.button_light')

  @Event onTouchAction?: (event: TouchEvent) => void

  build() {
    Column() {
      Image(this.icon)
        .width('50%')
        .height(this.icon ? this.width : 0)
        .fillColor(this.checked ? $r('app.color.text_color_check') : $r('app.color.text_color')) // 根据状态切换颜色
        .draggable(false)
      Text(this.label)
        .fontColor(this.checked ? $r('app.color.text_color_check') : $r('app.color.text_color'))
        .fontSize(this.label === '' ? 0 : this.fontSize)
        .maxLines(1)
    }
    .onTouch((event: TouchEvent) => {
      if (this.onTouchAction) {
        this.onTouchAction(event)
      }
    })
    .justifyContent(FlexAlign.Center)
    .borderRadius("15%")
    .linearGradient({
      angle: gradientAngle,
      colors: this.checked ?
        [[$r('app.color.button_checked_light'), 0.1],
          [$r('app.color.button_checked'), 1.0]] :
        [[this.buttonColor2, 0.1],
          [this.buttonColor, 1.0]]
    })
    .size({ width: '100%', height: '100%' })
    .backgroundColor(Color.Transparent)
    .margin({
      top: this.checked ? 3 : 0,
      left: this.checked ? 3 : 0
    })
    .shadow({
      radius: this.checked ? 8 : 15,
      color: $r('app.color.shadow'),
      fill:false,
      offsetX: this.checked ? 2 : 5,
      offsetY: this.checked ? 3 : 6
    })
    .animation({
      duration: animationDuration,
      curve: Curve.EaseInOut
    })
    .aspectRatio(1)
  }
}