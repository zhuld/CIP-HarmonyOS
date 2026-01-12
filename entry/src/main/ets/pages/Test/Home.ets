import { CrestronClient } from "../../crestron/CrestronClient";
import { ButtonModel } from "../../models/Models";
import { Category } from "../../components/Category";
import { NormalButton } from "../../components/NormalButton";
import { RoundButton } from "../../components/RoundButton";
import { testHome1, testHome2 } from "./Config";

@ComponentV2
export struct HomeComponent {
  @Param @Require crestronClient: CrestronClient

  @Builder
  SystemContent(buttonList: ButtonModel[], columns: number) {
    GridRow({
      columns: columns,
      gutter: { x: 40, y: 40 }
    }) {
      ForEach(buttonList, (item: ButtonModel) => {
        GridCol({ span: 1 }) {
          NormalButton({
            label: item.buttonName,
            icon: item.buttonIcon,
            buttonColor: item.buttonColor ? item.buttonColor : $r('app.color.button'),
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
            .height(100)
        }
      }, (item: ButtonModel) => item.buttonId.toString())
    }.padding({ right: 20, left: 20 })
  }

  @Builder
  ModeContent(buttonList: ButtonModel[], columns: number) {
    GridRow({
      columns: columns,
      gutter: { x: 80, y: 40 }
    }) {
      ForEach(buttonList, (item: ButtonModel) => {
        GridCol({ span: 1 }) {
          RoundButton({
            label: item.buttonName,
            icon: item.buttonIcon,
            fontSize: 24,
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
      }, (item: ButtonModel) => item.buttonId.toString())
    }.padding({ right: 50, left: 50 })
  }

  build() {
    Row({ space: 30 }) {
      Category({
        title: testHome1.title, // 动态绑定标题
        subTitle: testHome1.subTitle,
        icon: testHome1.icon,
        contentBuilder: () => {
          this.SystemContent(testHome1.buttonList, 1)
        }
      })
        .layoutWeight(1)

      Category({
        title: testHome2.title, // 动态绑定标题
        contentBuilder: () => {
          this.ModeContent(testHome2.buttonList, 2)
        } // 动态绑定内容
      })
        .layoutWeight(1)
    }
    .margin({ bottom: 10, right: 10, left: 2 })
  }
}