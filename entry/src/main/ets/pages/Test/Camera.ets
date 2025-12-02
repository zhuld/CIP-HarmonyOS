import { CrestronClient } from "../../crestron/CrestronClient";
import { ButtonModel } from "../../model/Models";
import { Category, RoundButton, SquareButton} from "../../view/Views";
import { Test_Camera, Test_Camera_Position } from "./Config";

@Component
export  struct CameraComponent {
  @ObjectLink crestronClient : CrestronClient
  @Consume channelDArray : boolean[] = []
  @Consume channelAArray : boolean[] = []
  @Builder
  CameraContent(buttonList :ButtonModel[],columns:number) {
    GridRow({
      columns: columns,
      gutter: { x: 10, y: -30 }
    }) {
      ForEach(buttonList, (item: ButtonModel,index) => {
        GridCol({ span: 1 }) {
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
      },(item: ButtonModel) => item.buttonId.toString())
    }.padding({right:30,left:30})
  }

  @Builder
  PositionContent(buttonList :ButtonModel[],columns:number) {
    GridRow({
      columns: columns,
      gutter: { x: 100, y: 30 }
    }) {
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
      },(item: ButtonModel) => item.buttonId.toString())
    }.padding({right:60,left:60})
  }

  build() {
    Row({ space: 30 }) {
      Category({
        title: '摄像机控制', // 动态绑定标题
        contentBuilder: () =>{
          this.CameraContent(Test_Camera,3)
        }
      })
        .layoutWeight(1)

      Category({
        title: '预置位', // 动态绑定标题
        contentBuilder: () =>{
          this.PositionContent(Test_Camera_Position,2)
        } // 动态绑定内容
      })
        .layoutWeight(1)
    }
    .margin({ bottom: 10, right: 10 ,left:2})
  }
}