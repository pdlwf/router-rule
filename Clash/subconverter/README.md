# subconverter 方案

这里放的是“在线订阅转换模板”相关文件。

- `Config.ini`
  - 主模板
  - 定义规则集、策略组、默认出口、地区分组
- `sr2clash.ini`
  - 轻量分组模板
  - 适合只想做节点分组，不想带完整规则生成的场景
- `GeneralConfig.yml`
  - 通用基础配置
- `GeneralConfig_OpenClash.yml`
  - OpenClash 兼容基础配置

典型使用方式：

1. 在 OpenClash / subconverter 中填机场订阅地址。
2. 用 `Config.ini` 或 `sr2clash.ini` 作为 `config=` 模板。
3. 转换器按这里的规则生成最终 Clash 配置。
