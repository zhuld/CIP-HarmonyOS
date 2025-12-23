import { SquareButton } from "./SquareButton"

@ComponentV2
export struct TabButton {
  @Param label: string | Resource | undefined = undefined
  @Param icon: Resource | undefined = undefined
  @Param fontSize: number = 20
  @Param checked: boolean = false
  @Param isEnabled: boolean = true
  @Event onTouchAction?: (event: TouchEvent) => void

  build() {
    SquareButton({
      label: this.label,
      icon: this.icon,
      fontSize: this.fontSize,
      checked: this.checked,
      buttonColor:$r('app.color.tab_button'),
      buttonColor2:$r('app.color.tab_button_light')
    })
      .onTouch((event: TouchEvent) => {
        if (this.onTouchAction && this.isEnabled) {
          this.onTouchAction(event)
        }
      })
  }
}
