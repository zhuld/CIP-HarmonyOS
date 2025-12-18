import { batteryInfo, BusinessError, commonEventManager } from '@kit.BasicServicesKit';
import { IconButton } from './IconButton';

@Component
export struct BatteryStatusComponent {
  @State batterySOC: string = "0%"; // 电量百分比
  @State chargingStatusText: string = ""; // 充电状态
  @State chargingStatus: number = 0
  @Prop sizeHeight: number = 20
  private subscriber: commonEventManager.CommonEventSubscriber | null = null;

  aboutToAppear() {
    // 订阅电池变化事件
    commonEventManager.createSubscriber(
      { events: [commonEventManager.Support.COMMON_EVENT_BATTERY_CHANGED] },
      (err: BusinessError, data: commonEventManager.CommonEventSubscriber) => {
        if (err) {
          console.error(`Failed to create subscriber. Code is ${err.code}, message is ${err.message}`);
          return;
        }
        this.subscriber = data;
        this.subscribeBatteryEvents();
      }
    );
    this.updateBatteryInfo()
  }

  private subscribeBatteryEvents() {
    if (this.subscriber) {
      commonEventManager.subscribe(this.subscriber, (err: BusinessError, data: commonEventManager.CommonEventData) => {
        if (err) {
          console.error(`Subscribe failed. Code is ${err.code}, message is ${err.message}`);
          return;
        }
        this.updateBatteryInfo();
      });
    }
  }

  updateBatteryInfo() {
    try {
      // 获取当前电量百分比
      const soc = batteryInfo.batterySOC;
      this.batterySOC = `${soc}%`;

      // 获取充电状态
      const chargeState = batteryInfo.chargingStatus;
      this.chargingStatusText = this.getChargeStatusText(chargeState);
      this.chargingStatus = chargeState;
    } catch (error) {
      console.error(`Failed to get battery info. Code is ${(error as BusinessError).code}`);
    }
  }

  private getChargeStatusText(state: number): string {
    switch (state) {
      case 0: return "未充电";
      case 1: return "充电中";
      case 2: return "放电中";
      case 3: return "已充满";
      default: return "未知状态";
    }
  }

  aboutToDisappear() {
    // 取消订阅
    if (this.subscriber) {
      commonEventManager.unsubscribe(this.subscriber, (err: BusinessError) => {
        if (err) {
          console.error(`Failed to unsubscribe. Code is ${err.code}`);
        }
      });
    }
  }

  build() {
    Row() {
      Text(this.batterySOC)
        .fontSize(this.sizeHeight)
        .fontColor(this.getBatteryColor())
      // Text(this.chargingStatusText)
      //   .fontSize(this.sizeHeight)
      //   .fontColor($r('app.color.text_color'))
      IconButton({
        icon: this.chargingStatus === 1? $r('app.media.charging'): $r('app.media.blank')
      })
        .width(this.sizeHeight)
    }
  }

  private getBatteryColor(): ResourceColor {
    const soc = parseInt(this.batterySOC);
    if (soc <= 20) return $r('app.color.text_color_red');
    if (soc <= 50) return $r('app.color.button_checked');
    return $r('app.color.text_color');
  }
}