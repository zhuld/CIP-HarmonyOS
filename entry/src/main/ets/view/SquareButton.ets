@Component
export struct SquareButton {
  private gradientAngle: number = 40
  @Prop label: string | Resource
  @Prop icon: Resource | undefined
  @Prop fontSize: number = 20
  @Prop checked: boolean = false
  @Prop buttonColor: ResourceColor =  $r('app.color.button')
  @Prop buttonColor2: ResourceColor =  $r('app.color.button_light')
  onTouchAction?: (event: TouchEvent) => void

  build() {
    Column() {
      Image(this.icon)
        .width('50%')
        .height(this.icon ? this.width : 0)
        .fillColor(this.checked ? $r('app.color.text_color_check') : $r('app.color.text_color')) // 根据状态切换颜色
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
      angle: this.gradientAngle,
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
      color: $r('app.color.shadow_color'),
      offsetX: this.checked ? 2 : 5,
      offsetY: this.checked ? 3 : 6
    })
    .animation({
      duration: 100,
      curve: Curve.EaseInOut
    })
    .aspectRatio(1)
  }
}