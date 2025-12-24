import { animationDuration, gradientAngle } from "../pages/global"

@ComponentV2
export struct MyButton {
  @Param label: string | Resource | undefined = undefined
  @Param icon: Resource | undefined = undefined
  @Param fontSize: number = 20
  @Local checked: boolean = false
  @Param buttonColor: ResourceColor =  $r('app.color.button')
  @Param buttonColor2: ResourceColor =  $r('app.color.button_light')

  build() {
    Row({ space: this.icon ? 5 : 0 }) {
      Image(this.icon)
        .width(this.icon ? this.fontSize : 0)
        .aspectRatio(1)
        .fillColor(this.checked ? $r('app.color.text_color_check') : $r('app.color.text_color')) // 根据状态切换颜色
      Text(this.label)
        .fontColor(this.checked ? $r('app.color.text_color_check') : $r('app.color.text_color'))
        .maxLines(1)
        .fontSize(this.fontSize)
    }
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Down) {
        this.checked = true;
      } else if (event.type === TouchType.Up) {
        this.checked = false
      }
    })
    .justifyContent(FlexAlign.Center)
    .borderRadius("5%")
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
      color:  ColoringStrategy.AVERAGE, //  $r('app.color.shadow_color'),
      fill: false,
      offsetX: this.checked ? 2 : 5,
      offsetY: this.checked ? 3 : 6
    })
    .animation({
      duration: animationDuration,
      curve: Curve.EaseInOut
    })
  }
}