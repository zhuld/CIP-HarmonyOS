import { animationDuration, gradientAngle, shadowRadius } from "../pages/Test/Config"

@ComponentV2
export struct NormalButton {
  @Param label: string | Resource | undefined = undefined
  @Param icon: Resource | undefined = undefined
  @Param fontSize: number = 20
  @Param checked: boolean = false
  @Param buttonColor: ResourceColor =  $r('app.color.button')
  @Param buttonColor2: ResourceColor =  $r('app.color.button_light')

  @Event onTouchAction?:(event: TouchEvent) => void

  build() {
    Row({space:this.icon? 10:0}) {
      Image(this.icon)
        .height(this.icon ? '60%' : 0)
        .aspectRatio(1)
        .fillColor(this.checked ? $r('app.color.text_color_check') : $r('app.color.text_color')) // 根据状态切换颜色
        .draggable(false)
      Text(this.label)
        .fontColor(this.checked ? $r('app.color.text_color_check') : $r('app.color.text_color'))
        .maxLines(1)
        .fontSize(this.fontSize)
    }
    .onTouch((event: TouchEvent) =>{
      if (this.onTouchAction) {
        this.onTouchAction(event)
      }
    })
    .justifyContent(FlexAlign.Center)
    .borderRadius(15)
    .linearGradient({
      angle: gradientAngle,
      colors: this.checked ?
        [ [$r('app.color.button_checked_light'), 0.1],
          [$r('app.color.button_checked'), 1.0]]:
        [[this.buttonColor2, 0.1],
          [this.buttonColor, 1.0]]
    })
    .size({ width: '100%', height: '100%'})
    .backgroundColor(Color.Transparent)
    .margin({
      top: this.checked ? 3 : 0,
      left: this.checked  ? 3 : 0
    })
    .shadow({
      radius: shadowRadius,
      color:  $r('app.color.shadow'),
      fill: false,
      offsetX: this.checked ? 0 : 5,
      offsetY: this.checked ? 0 : 6
    })
    .animation({
      duration: animationDuration,
      curve: Curve.EaseInOut
    })
  }
}