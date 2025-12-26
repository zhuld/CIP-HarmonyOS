// ColorAdjustUtil.ets
export class ColorUtil {
  /**
   * 调整颜色明度
   * @param color 原始颜色值（ARGB格式）
   * @param factor 调整系数：0.0-1.0（变暗），>1.0（变亮）
   * @returns 调整后的颜色值
   */
  static adjustLightness(color: number, factor: number): number {
    // 分解ARGB通道
    const alpha = (color >> 24) & 0xFF;
    const red = (color >> 16) & 0xFF;
    const green = (color >> 8) & 0xFF;
    const blue = color & 0xFF;

    // 转换到HSV空间
    const hsv = ColorUtil.rgbToHsv(red, green, blue);

    // 调整明度分量
    hsv[2] = Math.min(1, Math.max(0, hsv[2] * factor));

    // 转换回RGB空间
    const rgb = ColorUtil.hsvToRgb(hsv[0], hsv[1], hsv[2]);

    // 重组ARGB值
    return (alpha << 24) | (rgb[0] << 16) | (rgb[1] << 8) | rgb[2];
  }

  private static rgbToHsv(r: number, g: number, b: number): number[] {
    r /= 255; g /= 255; b /= 255;
    const max = Math.max(r, g, b), min = Math.min(r, g, b);
    let h = 0, s = 0, v = max;
    const d = max - min;

    s = max === 0 ? 0 : d / max;
    if (max === min) {
      h = 0;
    } else {
      switch (max) {
        case r: h = (g - b) / d + (g < b ? 6 : 0); break;
        case g: h = (b - r) / d + 2; break;
        case b: h = (r - g) / d + 4; break;
      }
      h /= 6;
    }
    return [h, s, v];
  }

  private static hsvToRgb(h: number, s: number, v: number): number[] {
    let r = 0, g = 0, b = 0;
    const i = Math.floor(h * 6);
    const f = h * 6 - i;
    const p = v * (1 - s);
    const q = v * (1 - f * s);
    const t = v * (1 - (1 - f) * s);

    switch (i % 6) {
      case 0: r = v; g = t; b = p; break;
      case 1: r = q; g = v; b = p; break;
      case 2: r = p; g = v; b = t; break;
      case 3: r = p; g = q; b = v; break;
      case 4: r = t; g = p; b = v; break;
      case 5: r = v; g = p; b = q; break;
    }
    return [Math.round(r * 255), Math.round(g * 255), Math.round(b * 255)];
  }
}