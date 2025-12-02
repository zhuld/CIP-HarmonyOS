import { preferences } from '@kit.ArkData';
import { common } from '@kit.AbilityKit';
import { MyButton } from '../view/Views';

@Entry
@Component
struct Config {
  @State ipAddress: string = '192.168.1.1';
  @State port: number = 8080;
  @State ipId: number = 3;
  private prefName: string = 'network_settings';
  private context = this.getUIContext().getHostContext() as common.UIAbilityContext;
  @State isIpAddress: boolean = true;
  @State isPort: boolean = true;
  @State isId: boolean = true;
  @State info:string = ''

  aboutToAppear() {
    this.loadSettings();
  }

  // 加载已保存的设置
  private async loadSettings() {
    try {
      const pref = await preferences.getPreferences(this.context, this.prefName);
      this.ipAddress = await pref.get('ip', '192.168.1.10') as string;
      this.port = await pref.get('port', 41794) as number;
      this.ipId = await pref.get('ipId', 3) as number;
    } catch (error) {
      console.error('加载设置失败:', error.message);
    }
  }

  // 保存设置到首选项
  private async saveSettings() : Promise<boolean> {
    if (!this.isValidIP(this.ipAddress)) {
      this.info = 'IP地址格式不正确'
      return Promise.resolve(false);
    }
    if (!this.isValidPort(this.port)) {
      this.info = '端口号范围1-65535'
      return Promise.resolve(false);
    }
    if (!this.isValidIpId(this.ipId)) {
      this.info = 'ID号范围1-255'
      return Promise.resolve(false);
    }
    this.info = ''
    try {
      const pref = await preferences.getPreferences(this.context, this.prefName);
      await pref.put('ip', this.ipAddress);
      await pref.put('port', this.port);
      await pref.put('idId', this.ipId);
      await pref.flush();
      return Promise.resolve(true)
    } catch (error) {
      console.error('保存失败:', error.message);
      return Promise.resolve(false)
    }
  }

  private isValidIP(ip: string): boolean {
    const pattern = /^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
    return pattern.test(ip);
  }

  private isValidPort(port: number): boolean {
    return ((port > 1 && port < 65535))
  }

  private isValidIpId(port: number): boolean {
    return ((port > 1 && port < 255))
  }

  build() {
    Column() {
      Scroll() {
        Column({ space: 20 }) {
          Row() {
            Text('IP地址：')
              .fontSize(32)
              .layoutWeight(1)
            TextInput({ text: this.ipAddress, placeholder: '输入IP地址' })
              .onChange((value: string) => {
                this.ipAddress = value;
                if (this.isValidIP(value)) {
                  this.isIpAddress = true
                  this.info = ''
                } else {
                  this.isIpAddress = false
                  this.info = 'IP地址格式不正确'
                }
              })
              .type(InputType.Normal)
              .fontColor(this.isIpAddress ? $r('app.color.text_color') : Color.Red)
              .placeholderFont({ size: 32 })
              .fontSize(32)
              .borderRadius(5)
              .layoutWeight(4)
          }

          Row() {
            Text('端口号：')
              .fontSize(32)
              .layoutWeight(1)
            TextInput({ text: this.port.toString(), placeholder: '输入端口号' })
              .type(InputType.Number)
              .onChange((value: string) => {
                this.port = Number(value);
                if (this.isValidPort(Number(value))) {
                  this.isPort = true
                  this.info = ''
                }else {
                  this.isPort = false
                  this.info = '端口号范围1-65535'
                }
              })
              .fontColor(this.isPort ? $r('app.color.text_color') : Color.Red)
              .placeholderFont({ size: 32 })
              .fontSize(32)
              .borderRadius(5)
              .layoutWeight(4)
          }

          Row() {
            Text('ID号：')
              .fontSize(32)
              .layoutWeight(1)
            TextInput({ text: this.ipId.toString(), placeholder: '输入ID号' })
              .type(InputType.Number)
              .onChange((value: string) => {
                this.ipId = Number(value);
                if (this.isValidIpId(Number(value))) {
                  this.isId = true
                  this.info = ''
                }else {
                  this.isId = false
                  this.info = 'ID号范围1-255'
                }
              })
              .fontColor(this.isId ? $r('app.color.text_color') : Color.Red)
              .placeholderFont({ size: 32 })
              .fontSize(32)
              .borderRadius(5)
              .layoutWeight(4)
          }
        }
      }
      .align(Alignment.Top)
      .width('100%')
      .height('48%')
      .scrollable(ScrollDirection.Vertical)

      Row({ space: 40 }) {
        MyButton({ label: '保存', fontSize: 32, })
          .layoutWeight(1)
          .height(70)
          .onClick(() => {
            this.saveSettings().then((result) => {
              if (result)
                this.getUIContext().getRouter().back();
            })
          })
        MyButton({ label: '应用', fontSize: 32, })
          .layoutWeight(1)
          .height(70)
          .onClick(() => {
            this.saveSettings();
          })
        MyButton({ label: '取消', fontSize: 32, })
          .layoutWeight(1)
          .height(70)
          .onClick(() => {
            this.getUIContext().getRouter().back()
          })
        Text(this.info)
          .fontSize(32)
          .layoutWeight(2)
          .fontColor(Color.Red)
          .height(80)
      }
      .height('8%')
      .width('100%')
      .direction(Direction.Rtl)
    }
    .padding(40)
    .height('100%')
    .backgroundColor(Color.Transparent)
    .linearGradient({
      angle:180,
      colors:[
        [$r('app.color.background_1'), 0.0],
        [$r('app.color.background_2'), 1],
      ]
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}