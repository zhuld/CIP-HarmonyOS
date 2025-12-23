@ComponentV2
export struct RoundButton {
  private gradientAngle: number = 40
  @Param label: string | Resource | undefined = undefined
  @Param icon: Resource | undefined = undefined
  @Param fontSize: number = 20
  @Param checked: boolean = false
  @Param buttonColor: ResourceColor =  $r('app.color.button')
  @Param buttonColor2: ResourceColor =  $r('app.color.button_light')

  @Event onTouchAction?:(event: TouchEvent) => void

  build() {
    RelativeContainer() {
      Stack() {
        Image(this.icon)
          .width('60%')
          .height(this.icon ? this.width : 0)
          .fillColor(this.checked ? $r('app.color.text_color_check') : $r('app.color.text_color')) // 根据状态切换颜色
      }
      .onTouch((event: TouchEvent) =>{
        if (this.onTouchAction) {
          this.onTouchAction(event)
        }
      })
      .width('100%')
      .aspectRatio(1)
      .borderRadius('50%')
      .backgroundColor(Color.Transparent)
      .linearGradient({
        angle: this.gradientAngle,
        colors: this.checked ?
          [[$r('app.color.button_checked_light'), 0.1],
            [$r('app.color.button_checked'), 1.0]] :
          [[this.buttonColor2, 0.1],
            [this.buttonColor, 1.0]]
      })
      .shadow({
        radius: this.checked ? 8 : 15,
        color:  ColoringStrategy.AVERAGE, //  $r('app.color.shadow_color'),
        fill: false,
        offsetX: this.checked ? 2 : 5,
        offsetY: this.checked ? 3 : 6
      })
      .margin({
        top: this.checked ? 3 : 0,
        left: this.checked ? 3 : 0
      })
      .animation({
        duration: 100,
        curve: Curve.EaseInOut
      })

      Text(this.label)
        .fontColor($r('app.color.text_color'))
        .fontSize(this.fontSize)
        .textAlign(TextAlign.Center)
        .maxLines(1)
        .width('100%')
        .alignRules({
          bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
        })
    }
    .width('100%')
    .aspectRatio(0.75)
  }
}
