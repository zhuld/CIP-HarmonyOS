import { CrestronClient } from "../../crestron/CrestronClient";
import { ButtonModel } from "../../model/Models";
import { Category } from "../../view/Category";
import { NormalButton } from "../../view/NormalButton";
import { RoundButton } from "../../view/RoundButton";
import { testHome1, testHome2 } from "./Config";

@ComponentV2
export struct HomeComponent {
  @Param @Require crestronClient : CrestronClient
  @Builder
  SystemContent(buttonList :ButtonModel[],columns:number) {
    GridRow({
      columns: columns,
      gutter: { x: 40, y: 40 }
    }) {
      ForEach(buttonList, (item: ButtonModel) => {
        GridCol({ span: 1 }) {
          NormalButton({
            label: item.buttonName,
            icon: item.buttonIcon,
            buttonColor: item.buttonColor? item.buttonColor: $r('app.color.button'),
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
            .height(80)
        }
      }, (item: ButtonModel) => item.buttonId.toString())
    }.padding({ right: 20, left: 20 })
  }

  @Builder
  ModeContent(buttonList :ButtonModel[],columns:number) {
    GridRow({
      columns: columns,
      gutter: { x: 40, y: 40 }
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
      },(item: ButtonModel) => item.buttonId.toString())
    }.padding({right:20,left:20})
  }

  build() {
    Row({ space: 30 }) {
      Category({
        title: testHome1.title, // 动态绑定标题
        subTitle: testHome1.subTitle,
        icon:testHome1.icon,
        contentBuilder: () =>{
          this.SystemContent(testHome1.buttonList,1)
        }
      })
        .layoutWeight(2)

      Category({
        title: testHome2.title, // 动态绑定标题
        contentBuilder: () =>{
          this.ModeContent(testHome2.buttonList,3)
        } // 动态绑定内容
      })
        .layoutWeight(3)
    }
    .margin({ bottom: 10, right: 10 ,left:2})
  }
}