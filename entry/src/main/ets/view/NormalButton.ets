@Component
export struct NormalButton {
  private  gradientAngle: number = 40
  @Prop label: string | Resource
  @Prop icon: Resource
  @Prop fontSize: number = 20
  @Prop checked: boolean = false

  onTouchAction?:(event: TouchEvent) => void

  build() {
    Row({space:this.icon? 10:0}) {
      Image(this.icon)
        .height(this.icon ? '60%' : 0)
        .aspectRatio(1)
        .fillColor(this.checked ? $r('app.color.text_color_check') : $r('app.color.text_color')) // 根据状态切换颜色
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
    .borderRadius("5%")
    .linearGradient({
      angle: this.gradientAngle,
      colors: this.checked ?
        [ [$r('app.color.button_checked_light'), 0.1],
          [$r('app.color.button_checked'), 1.0]]:
        [ [$r('app.color.button_light'), 0.1],
          [$r('app.color.button'), 1.0] ]
    })
    .size({ width: '100%', height: '100%'})
    .backgroundColor(Color.Transparent)
    .margin({
      top: this.checked ? 3 : 0,
      left: this.checked  ? 3 : 0
    })
    .shadow({
      radius: this.checked  ? 8 : 15,
      color: $r('app.color.shadow_color'),
      offsetX: this.checked ? 2 : 5,
      offsetY: this.checked ? 3 : 6
    })
    .animation({
      duration: 100,
      curve: Curve.EaseInOut
    })
  }
}