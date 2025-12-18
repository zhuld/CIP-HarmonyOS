import { CrestronClient } from "../../crestron/CrestronClient";
import { ButtonModel } from "../../model/Models";
import { Category } from "../../view/Category";
import { RoundButton } from "../../view/RoundButton";
import { SquareButton } from "../../view/SquareButton";
import { testCamera, testPosition } from "./Config";

@Component
export  struct CameraComponent {
  @ObjectLink crestronClient: CrestronClient
  @Consume channelDArray: boolean[] = []
  @Consume channelAArray: number[] = []

  @Builder
  CameraContent(buttonList: ButtonModel[], columns: number) {
    GridRow({
      columns: columns,
      gutter: { x: 10, y: -30 }
    }) {
      ForEach(buttonList, (item: ButtonModel, index?: number) => {
        GridCol({ span: 1 }) {
          if (index !== undefined) {
            if (buttonList[index].buttonId === 0) {
              Text(``)
            } else {
              RoundButton({
                label: item.buttonName,
                icon: item.buttonIcon,
                fontSize: 30,
                checked: this.channelDArray[item.buttonId],
                onTouchAction: (event: TouchEvent) => {
                  if (event.type === TouchType.Down) {
                    this.crestronClient?.push(item.buttonId)
                  } else if (event.type === TouchType.Up) {
                    this.crestronClient?.release(item.buttonId)
                  }
                }
              })
            }
          }
        }
      }, (item: ButtonModel) => item.buttonId.toString())
    }.padding({ right: 30, left: 30 })
  }

  @Builder
  PositionContent(buttonList: ButtonModel[], columns: number) {
    GridRow({
      columns: columns,
      gutter: { x: 120, y: 20 }
    }) {
      GridCol({ span: 2 }) {
        Rect()
          .width(160)
          .height(10)
          .margin(10)
          .fill($r('app.color.button_light'))
      }

      ForEach(buttonList, (item: ButtonModel) => {
        GridCol({ span: 1 }) {
          SquareButton({
            label: item.buttonName,
            icon: item.buttonIcon,
            fontSize: 30,
            checked: this.channelDArray[item.buttonId],
            onTouchAction: (event: TouchEvent) => {
              if (event.type === TouchType.Down) {
                this.crestronClient?.push(item.buttonId)
              } else if (event.type === TouchType.Up) {
                this.crestronClient?.release(item.buttonId)
              }
            }
          })
        }
      }, (item: ButtonModel) => item.buttonId.toString())
      GridCol({ span: 2 }) {
        SquareButton({
          label: "9",
          fontSize: 30,
          checked: this.channelDArray[79],
          onTouchAction: (event: TouchEvent) => {
            if (event.type === TouchType.Down) {
              this.crestronClient?.push(79)
            } else if (event.type === TouchType.Up) {
              this.crestronClient?.release(79)
            }
          }
        }).width('27%')
      }
    }.padding({ right: 70, left: 70 })
  }

  build() {
    Row({ space: 30 }) {
      Category({
        title: testCamera.title, // 动态绑定标题
        contentBuilder: () => {
          this.CameraContent(testCamera.buttonList, 3)
        }
      })
        .layoutWeight(1)

      Category({
        title: testPosition.title, // 动态绑定标题
        subTitle: testPosition.subTitle,
        checkButton: testPosition.checkId ? true : false,
        checked: this.channelDArray[testPosition.checkId],
        onTouchAction: (event: TouchEvent) => {
          if (event.type === TouchType.Down) {
            this.crestronClient?.push(testPosition.checkId)
          } else if (event.type === TouchType.Up) {
            this.crestronClient?.release(testPosition.checkId)
          }
        },
        contentBuilder: () => {
          this.PositionContent(testPosition.buttonList, 2)
        } // 动态绑定内容
      })
        .layoutWeight(1)
    }
    .margin({ bottom: 10, right: 10, left: 2 })
  }
}