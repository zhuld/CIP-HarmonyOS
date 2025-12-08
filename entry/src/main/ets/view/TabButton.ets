import { SquareButton } from "./SquareButton"

@Component
export struct TabButton {
  @Prop label: string | Resource
  @Prop icon: Resource | undefined
  @Prop fontSize: number = 20
  @Prop checked: boolean = false
  @Prop isEnabled: boolean = true
  onTouchAction?: (event: TouchEvent) => void

  build() {
    SquareButton({
      label: this.label,
      icon: this.icon,
      fontSize: this.fontSize,
      checked: this.checked
    })
      .onTouch((event: TouchEvent) => {
        if (this.onTouchAction && this.isEnabled) {
          this.onTouchAction(event)
        }
      })
  }
}
