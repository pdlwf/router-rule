# Clash 目录说明

这个目录现在按两套方案拆开了，后续改配置时先确认你在改哪一套。

## 1. `subconverter/`

这一套是“在线订阅转换模板”方案。

- 入口文件：
  - `Config.ini`
  - `sr2clash.ini`
- 配套基础配置：
  - `GeneralConfig.yml`
  - `GeneralConfig_OpenClash.yml`
- 适用场景：
  - OpenClash / subconverter 里使用 `config=` 模板地址
  - 机场订阅先经过在线转换，再生成最终 Clash 配置
- 你后面如果要改：
  - 分流规则入口、策略组默认出口、地区分组正则：改 `subconverter/Config.ini`
  - 基础 DNS / 端口 / script / 通用 rules：改 `subconverter/GeneralConfig*.yml`
  - Shadowrocket / 简化分组模板：改 `subconverter/sr2clash.ini`

## 2. `provider/`

这一套是“直接导入 OpenClash 主配置 / proxy-providers”方案。

- 当前主用双订阅 A/B 兜底配置：
  - `proxy-providers-a-b-fallback.yaml`
- 其他 provider 方案或历史样例：
  - `proxy-providers.yaml`
  - `config.yaml`
- 适用场景：
  - 直接把 YAML 作为 OpenClash 配置文件导入
  - 订阅 A / B 在 YAML 里作为 `proxy-providers` 维护
  - 需要“同地区 A 优先，A 挂了再切 B”
- 你后面如果要改：
  - 节点怎么按地区 / AI / 游戏筛选：改 `provider/proxy-providers-a-b-fallback.yaml`
  - 服务默认走哪个组：改 `provider/proxy-providers-a-b-fallback.yaml`
  - provider 更新、DNS、自恢复逻辑：也改 `provider/proxy-providers-a-b-fallback.yaml`

## 3. `shared/Rule/`

这是两套方案共用的本地规则文件目录。

- 当前会被调用的主要文件：
  - `bobby_customize.yaml`
  - `platform-openai.yaml`
- 可能按需启用：
  - `bobby_lan.yaml`
  - 其他自定义规则文件

如果你改的是“域名 / 规则集内容”，优先检查这里。

## 4. 修改时怎么判断该改哪套

- 你在 OpenClash 里填的是 `config=...Config.ini`
  - 改 `subconverter/`
- 你在 OpenClash 里直接导入的是完整 YAML
  - 改 `provider/`

不要在没确认入口的情况下同时改两套，不然很容易出现“明明改了文件但路由器不生效”。
