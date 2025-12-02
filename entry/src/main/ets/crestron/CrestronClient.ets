import socket from '@ohos.net.socket';

const op_Server_Accept = 0x0F // 服务器接受连接 0F 00 01 02
const op_Client_IPID = 0x01 // 发送IPID 01 00 0B 00 00 00 00 00 XX 40 FF FF F1 01
const op_Server_IPID = 0x02 // 回复 02 00 04 00 00 00 1F ok; 02 00 03 FF FF 02 failed

const op_Join = 0x05 // 发送 Join信息
const op_Join_Digital = 0x00
const op_Join_Digital1 = 0x27
const op_Join_Analog1 = 0x01
const op_Join_Analog = 0x14
//const op_Join_Serial = 0x02

const op_Join_Request = 0x03

const op_Client_Ping = 0x0D // 定时发送 0D 00 02 00 00
const op_Server_Pong = 0x0E // 回复 0E 00 02 00 00

 export  enum JoinType {
  Digital, // 0
  Analog, // 1
  Serial, // 2
}

@Observed
export class CrestronClient {
  private tcpSocket = socket.constructTCPSocketInstance();
  //private isConnected: boolean = false;
  private cipId: number = 3;
  channelDArray: boolean[] = [];
  channelAArray: number[] = []

  constructor() {
    this.tcpSocket.bind({
      address: '0.0.0.0',
      port: 0  // 系统自动分配端口
    }).catch((error: Error) => {
      console.error(`TCP连接失败: ${error.message}`);
    });

    for (let i = 0; i < 500; i++) {
      this.channelDArray.push(false)
    }
    for (let i = 0; i < 100; i++) {
      this.channelAArray.push(0)
    }
  }

  // 连接服务器
  async connect(serverIP: string, port: number, cipId: number): Promise<boolean> {
    if (cipId > 1 && cipId < 255) {
      this.cipId = cipId
    }
    try {
      await this.tcpSocket.connect({
        address: {
          address: serverIP,
          port: port,
          family: 1
        },
        timeout: 3000
      })
      console.info(`TCP连接成功: ${serverIP}:${port}-${cipId}`);
      return true;
    } catch (error) {
      console.error(`TCP连接失败: ${error.message} ${serverIP}:${port}-${cipId}`);
      return false;
    }
  }

  // 发送数据
  async sendData(data: string): Promise<boolean> {
    try {
      await this.tcpSocket.send({
        data: data
      });
      console.info('数据发送成功');
      return true;
    } catch (error) {
      console.error(`数据发送失败: ${error.message}`);
      return false;
    }
  }

  async push(join: number) {
    if (join > 0 && join < 32767) {
      join = join - 1;
      try {
        await this.tcpSocket.send({
          data: this.crestronMessageData(
            op_Join,
            new Uint8Array([0x00, 0x00, 0x03, op_Join_Digital, join % 0x100, join / 0x100]))
        })
      } catch (error) {
        console.error(`push发送失败: ${error.message}`);
      }
    }
  }

  async release(join: number) {
    if (join > 0 && join < 32767) {
      join = join - 1;
      try {
        await this.tcpSocket.send({
          data: this.crestronMessageData(
            op_Join,
            new Uint8Array([0x00, 0x00, 0x03, op_Join_Digital, join % 0x100, join / 0x100 | 0x80]))
        })
      } catch (error) {
        console.error(`release发送失败: ${error.message}`);
      }
    }
  }

  async ping() {
    try {
      await this.tcpSocket.send({
        data: this.crestronMessageData(
          op_Client_Ping,
          new Uint8Array([0x00, 0x00]))
      })
    } catch (error) {
      console.error(`ping发送失败: ${error.message}`);
    }
  }

  async level(join: number, value: number) {
    if (join > 0 && join < 32767) {
      join = join - 1
      try {
        await this.tcpSocket.send({
          data: this.crestronMessageData(
            op_Join,
            new Uint8Array([0x00, 0x00, 0x05, op_Join_Analog, join / 0x100, join % 0x100, value / 0x100,
              value % 0x100]))
        })
      } catch (error) {
        console.error(`level发送失败: ${error.message}`);
      }
    }
  }

  crestronMessageData(opCode: number, message: Uint8Array) {
    let m = new Uint8Array(message.length + 3)
    m[0] = opCode
    m[1] = message.length / 0x100
    m[2] = message.length % 0x100
    m.set(message, 3)
    return m.buffer
  }

  setupConnectListener(callback: (isConnected: boolean) => void) {
    this.tcpSocket.on('close', () => {
      console.info('TCP连接已关闭');
      //this.isConnected = false;
      callback(false);
    });

    this.tcpSocket.on('connect', () => {
      console.info('TCP已连接');
      //this.isConnected = true;
      callback(true);
    });

    this.tcpSocket.on('error', (error: Error) => {
      console.error(`TCP错误: ${error.message}`);
      //this.isConnected = false;
      callback(false);
    });
  }

  setupStatusListener(callback: ( joinType: JoinType, channel: number,value: number) => void) {
    this.tcpSocket.on('message', async (value) => {
      if (!value || !value.message) {
        console.error('接收数据失败');
        return;
      }
      const message = await new Promise<Uint8Array>((resolve) => {
        const buffer: ArrayBuffer = value.message;
        const data: Uint8Array = new Uint8Array(buffer);
        resolve(data);
      });
      let index = 0
      while (index < message.length) {
        let payloadType = message[index]
        let payloadLength = message[index + 2]
        let payload = message.slice(index + 3, index + 3 + payloadLength)
        switch (payloadType) {
          case op_Server_Accept:
            if (payload.length === 1 && payload[0] === 0x02) {
              try {
                await this.tcpSocket.send({
                  data: this.crestronMessageData(
                    op_Client_IPID,
                    new Uint8Array([0x00, 0x00, 0x00, 0x00, 0x00, this.cipId, 0x40, 0xFF, 0xFF, 0xF1, 0x01]))
                })
              } catch (error) {
                console.error(`发送IPID失败: ${error.message}`);
              }
            }
            break
          case op_Server_IPID:
            if (this.toHexString(payload, "") === "0000001F" || this.toHexString(
              payload, "") === "00000003") {
              try {
                await this.tcpSocket.send({
                  data: this.crestronMessageData(
                    op_Join,
                    new Uint8Array([0x00, 0x00, 0x02, op_Join_Request, 0x00]))
                })
              } catch (error) {
                console.error(`发送注册失败: ${error.message}`);
              }
            } else if (this.toHexString(payload, "") === "FFFF02") {
              console.error(`服务器注册失败`);
            }
            break
          case op_Join:
            //Join事件
            switch (payload[3]) {
              case op_Join_Digital:
              case op_Join_Digital1:
                //digital
                let channelD = payload[4] + (payload[5] & 0x7F) * 0x100 + 1
                if (isNaN(channelD) === false) {
                  let value = !(payload[5] & 0x80)
                  if (this.channelDArray[channelD] !== value) {
                    this.channelDArray[channelD] = value
                    callback(JoinType.Digital, channelD, value ? 1 : 0)
                  }
                }
                break
              case op_Join_Analog1:
              case op_Join_Analog:
                if (payloadLength === 8) {
                  let channelA = payload[4] * 0x100 + payload[5] + 1
                  if (isNaN(channelA) === false) {
                    this.channelAArray[channelA] = payload[6] * 0x100 + payload[7]
                    callback(JoinType.Analog, channelA, this.channelAArray[channelA])
                  }
                } else if (payloadLength === 7) {
                  let channelA = payload[4] + 1
                  if (isNaN(channelA) === false) {
                    this.channelAArray[channelA] = payload[5] * 0x100 + payload[6]
                    callback(JoinType.Analog, channelA, this.channelAArray[channelA])
                  }
                }
                break
            }
            break
          case op_Server_Pong:
            //console.log('pong')
            break
        }
        index = index + payloadLength + 3
      }
    })
  }
  private toHexString(data: Uint8Array, space: string): string {
    let hexMessage = ""
    let s = space
    for (let i = 0; i < data.length; i++) {
      let hex = data[i].toString(16)
      // 将字节转换为十六进制
      if (hex.length < 2) {
        hex = "0" + hex // 补齐两位
      }
      hexMessage += hex
      hexMessage += s
    }
    return hexMessage.toUpperCase()
  }

  // 关闭连接
  async close(): Promise<boolean> {
    try {
      await this.tcpSocket.close();
      console.info('TCP连接已关闭');
      return true;
    } catch (error) {
      console.error(`关闭连接失败: ${error.message}`);
      return false;
    }
  }
}


