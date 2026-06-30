# Mission:从零构建一个 voicebox 式的本地 AI 语音应用

## 为什么

我要能做到**从零构建一个本地优先(local-first)的 AI 语音应用** —— 一个在自己机器上跑语音模型(TTS、声音克隆、语音听写)、可打包分发的桌面应用,以 `jamiepine/voicebox` 为参考样本。具体产出:我能对着一个空文件夹,不照抄 voicebox,做出一个能跑的语音 I/O 应用,因为我懂了它每一层是怎么搭起来的。

## 成功标准(success looks like)

- 我能搭起一个 **Tauri** 桌面应用:托管 React UI,并在本地端口拉起一个 **Python FastAPI sidecar**。
- 我能在 **Apple Silicon** 上(torch / MLX)通过 API 提供**本地 TTS 模型**,把音频流回 UI —— 打字,出声。
- 我能从几秒参考音频**克隆一个声音**,并用它生成语音。
- 我能接上**听写输入**(本地 STT + 全局热键),让它能把字打进别的 app。
- 我能**讲清楚(不只是跑通)**TTS 和声音克隆在架构层面怎么工作,从而能为不同需求选引擎(Kokoro vs Chatterbox vs Qwen3-TTS …)。
- 我能把整套**打包**(PyInstaller 做 sidecar + `tauri build`)成别人能装的 Mac 应用。
- **毕业项目**:不打开 voicebox 代码,从零做出一个最小可用的语音 I/O 应用(克隆 + TTS + 听写)。

## 约束

- **机器**:Mac(Apple Silicon,M 系列)。模型部署目标是 MPS / MLX —— **不是** CUDA/ROCm(那两个只作为"voicebox 怎么支持它们"讲一下概念)。
- **深度**:部署 + 懂原理。**不做 ML 训练或微调**。用现有开源权重模型,学的是它们怎么拼、怎么 serve,不是怎么训。
- **舒适区**:我已会 **React / TypeScript**。前端是我的入口;Rust/Tauri、Python 后端、本地模型部署是要补的三层。
- 时间:多 session、按自己节奏(这是一门状态化课程,不是一次性)。

## 范围外

- 训练 / 微调语音模型、架构层以下的 ML 理论、数据集准备。
- 非 Mac 部署深挖(CUDA build flags、ROCm)—— 只讲概念。
- 营销站(`landing/`)和文档站(`docs/`)作为构建目标。
- voicebox 长尾的全部功能(每种特效、每种语言)—— 学范式,不背清单。
