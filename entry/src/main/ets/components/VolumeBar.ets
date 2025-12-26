import { RoundButton } from "./RoundButton"

@ComponentV2
export struct  VolumeBar {
  @Param name: string | Resource | undefined = undefined
  @Param min: number = 0
  @Param max: number = 100
  @Param value: number = 0
  @Param checked: boolean = false
  private lastValue: number = 0
  @Local pressed: boolean = false
  @Event onMuteAction?: (event: TouchEvent) => void
  @Event onVolumeChanged?: (value: number) => void

  build() {
    Column({ space: 10 }) {
      Text(this.name)
        .fontSize(30)
        .layoutWeight(1)
        .maxLines(1)
        .fontColor($r('app.color.text_color'))
      Text((Math.floor(this.value * (this.max - this.min) / 65535) + this.min).toString())
        .fontSize(30)
        .layoutWeight(1)
        .maxLines(1)
        .fontColor($r('app.color.text_color'))
      Slider({
        min: this.min,
        max: this.max,
        value: Math.floor(this.value * (this.max - this.min) / 65535) + this.min,
        step: 1,
        direction: Axis.Vertical,
        reverse: true,
      })
        .layoutWeight(10)
        .blockColor(this.pressed ? $r('app.color.button_checked') : $r('app.color.button_light'))
        .trackThickness(10) // 设置滑动条粗细为10
        .trackColor($r('app.color.catalog_background_2'))
        .selectedColor($r('app.color.button_checked_light'))
        .showSteps(true)
        .minResponsiveDistance(1)
        .onChange((value: number) => {
          if (this.lastValue !== value) {
            this.lastValue = value
          } else {
            if (this.onVolumeChanged) {
              this.onVolumeChanged(Math.floor((value - this.min) / (this.max - this.min) * 65535))
            }
          }
        })
      RoundButton({
        checked: this.checked,
        icon: this.checked ? $r('app.media.mute') : $r('app.media.unmute')
      })
        .width('70')
        .onTouch((event: TouchEvent) => {
          if (this.onMuteAction) {
            this.onMuteAction(event)
          }
        })
    }
  }
}