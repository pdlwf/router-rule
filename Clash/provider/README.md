# provider 方案

这里放的是“直接导入完整 Clash/OpenClash YAML”的方案。

- `proxy-providers-a-b-fallback.yaml`
  - 当前主用版本
  - 支持双订阅 A/B
  - 同地区 A 优先，A 故障时切 B
- `proxy-providers.yaml`
  - 单订阅 provider 方案样例
- `config.yaml`
  - 完整主配置样例

典型使用方式：

1. 直接把 YAML 导入 OpenClash。
2. 在 YAML 里填真实订阅地址。
3. 由 `proxy-providers` 自动拉取节点并更新。

这一套不依赖 `config=` 在线转换模板。
