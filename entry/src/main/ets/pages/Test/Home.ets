import { CrestronClient } from "../../crestron/CrestronClient";
import { ButtonModel } from "../../model/Models";
import { NormalButton ,Category, RoundButton} from "../../view/Views";
import { Test_Home_1, Test_Home_2 } from "./Config";

@Component
export  struct HomeComponent {
  @ObjectLink crestronClient : CrestronClient
  @Consume channelDArray : boolean[] = []
  @Consume channelAArray : boolean[] = []
  @Builder
  SystemContent(buttonList :ButtonModel[],columns:number) {
    RelativeContainer() {
      GridRow({
        columns: columns,
        gutter: { x: 40, y: 40 }
      }) {
        ForEach(buttonList, (item: ButtonModel) => {
          GridCol({ span: 1 }) {
            NormalButton({
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
              .height(80)
          }
        }, (item: ButtonModel) => item.buttonId.toString())
      }
      Text('长按2秒')
        .fontSize(26)
        .alignRules({
          bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
          end: { anchor: '__container__', align: HorizontalAlign.End }
        })
    }.padding({right:20,left:20})
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
      },(item: ButtonModel) => item.buttonId.toString())
    }.padding({right:20,left:20})
  }

  build() {
    Row({ space: 30 }) {
      Category({
        title: '系统开关', // 动态绑定标题
        contentBuilder: () =>{
          this.SystemContent(Test_Home_1,1)
        }
      })
        .layoutWeight(2)

      Category({
        title: '模式选择', // 动态绑定标题
        contentBuilder: () =>{
          this.ModeContent(Test_Home_2,3)
        } // 动态绑定内容
      })
        .layoutWeight(3)
    }
    .margin({ bottom: 10, right: 10 ,left:2})
  }
}