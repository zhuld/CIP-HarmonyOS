import { CrestronClient } from "../../crestron/CrestronClient";
import { ButtonModel } from "../../models/Models";
import { Category } from "../../components/Category";
import { RoundButton } from "../../components/RoundButton";
import { SquareButton } from "../../components/SquareButton";
import { buttonRadius, gradientAngle, shadowOffsetX,
  shadowOffsetY,
  shadowRadius, testCamera, testPosition } from "./Config";

@ComponentV2
export struct CameraComponent {
  @Param @Require  crestronClient: CrestronClient

  @Builder
  CameraContent(buttonList: ButtonModel[]) {
    GridRow({
      columns: 3,
      gutter: { x: 10, y: -30 }
    }) {
      ForEach(buttonList, (item: ButtonModel, index?: number) => {
        GridCol() {
          if (index !== undefined) {
            if (buttonList[index].buttonId === 0) {
              Text(``)
            } else {
              RoundButton({
                label: item.buttonName,
                icon: item.buttonIcon,
                fontSize: 30,
                checked: this.crestronClient.channelDArray[item.buttonId],
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
    }
    .padding({ right: 30, left: 30 })
  }

  @Builder
  PositionContent(buttonList: ButtonModel[]) {
    Column({space:30}) {
      Rect()
        .width(160)
        .height(10)
        .fill($r('app.color.button'))
        .stroke($r('app.color.button_light'))
        .strokeWidth(1)
        .radius(2)
      GridRow({
        columns: 2,
        gutter: { x: 120, y: 20 }
      }) {
        ForEach(buttonList, (item: ButtonModel, index: number) => {
          GridCol({ span: index + 1 < buttonList.length ? 1 : 2 }) {
            SquareButton({
              label: item.buttonName,
              icon: item.buttonIcon,
              fontSize: 30,
              checked: this.crestronClient.channelDArray[item.buttonId],
              onTouchAction: (event: TouchEvent) => {
                if (event.type === TouchType.Down) {
                  this.crestronClient?.push(item.buttonId)
                } else if (event.type === TouchType.Up) {
                  this.crestronClient?.release(item.buttonId)
                }
              }
            })
              .width(index + 1 < buttonList.length ? '100%' : '27%')
          }
        }, (item: ButtonModel) => item.buttonId.toString())
      }
      .padding(30)
      .margin({right:50,left:50})
      .borderRadius(buttonRadius)
      .linearGradient({
        angle: gradientAngle,
        colors: [
          [$r('app.color.category_background_1'), 0.4],
          [$r('app.color.category_background_2'), 1]
        ]
      })
      .shadow({
        radius: shadowRadius,
        color: $r('app.color.shadow'),
        fill: true,
        offsetX: shadowOffsetX,
        offsetY: shadowOffsetY,
      })
    }
  }

  build() {
    Row({ space: 30 }) {
      Category({
        title: testCamera.title, // 动态绑定标题
        contentBuilder: () => {
          this.CameraContent(testCamera.buttonList)
        }
      })
        .layoutWeight(1)

      Category({
        title: testPosition.title, // 动态绑定标题
        subTitle: testPosition.subTitle,
        checkButton: testPosition.checkId ? true : false,
        checked: this.crestronClient.channelDArray[testPosition.checkId],
        onTouchAction: (event: TouchEvent) => {
          if (event.type === TouchType.Down) {
            this.crestronClient?.push(testPosition.checkId)
          } else if (event.type === TouchType.Up) {
            this.crestronClient?.release(testPosition.checkId)
          }
        },
        contentBuilder: () => {
          this.PositionContent(testPosition.buttonList)
        } // 动态绑定内容
      })
        .layoutWeight(1)
    }
    .margin({ bottom: 10, right: 10, left: 2 })
  }
}