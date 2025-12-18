
@Component
export struct IconButton {
  @Prop icon: Resource | undefined = undefined
  @Prop checked: boolean = false

  onTouchAction?:(event: TouchEvent) => void

  build() {
    Row({space:5}) {
      Image(this.icon)
        .width('100%')
        .aspectRatio(1)
        .fillColor(this.checked ? $r('app.color.text_color_check'):$r('app.color.text_color')) // 根据状态切换颜色
    }
    .onTouch((event: TouchEvent) =>{
      if (this.onTouchAction) {
        this.onTouchAction(event)
      }
    })
    .justifyContent(FlexAlign.Center)
    .size({ width: '100%', height: '100%'})
  }
}

