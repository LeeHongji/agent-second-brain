# Path:voicebox —— 从零构建一个本地 AI 语音应用

**状态**:in-progress
**Mission**:[[MISSION.md]]
**最后修订**:2026-06-30

## 方向

从你会的(React/TS)出发,一层层往上爬:先**看清全貌 + 把 voicebox 跑起来**,再上 **Tauri 外壳**(离 web 最近的新层),再 **Python FastAPI sidecar**,再**在 Mac 上 serve 本地模型**。等管道会说话了(TTS),就**横向吃语音领域** —— TTS 原理、克隆、听写(STT)、特效 + 内置 LLM —— 最后**纵向收口到发布**:sidecar + Tauri 打成可分发 Mac app,以从零毕业项目收尾。每个里程碑都以"能跑出来或能讲清楚"收束;每个新层都紧邻你刚拿下的那一层。

## 里程碑

- [~] ▶ **M1 — 定位 + 跑起来** · sidecar 架构 + 在 Mac 上把 voicebox 在 dev 模式跑起来
      _达标证据_:能凭记忆画出 React→Tauri→FastAPI-sidecar→models 的图;dev 应用在你机器上能启动。
- [ ] ◇ **M2 — Tauri 外壳** · Rust+web IPC、窗口/托盘/热键、拉起子进程(sidecar 的种子)
      _达标证据_:一个 host React UI 的 hello-Tauri,能拉起子进程并读它的 stdout。
- [ ] ◇ **M3 — Python FastAPI sidecar** · FastAPI 基础、`backend/` 结构(routes/services/backends)、Tauri→Python 的 HTTP
      _达标证据_:Tauri 按钮调本地 FastAPI 端点、把结果显示在 UI。
- [ ] ◇ **M4 — 跑通第一个本地模型(TTS)** · 在 Apple Silicon 上用 torch/MLX 加载 Kokoro、暴露 `/tts`、音频流回
      _达标证据_:UI 打字 → 听到它说话,端到端,在你 Mac 上。
- [ ] ◇ **M5 — TTS 原理 + 引擎版图** · TTS 怎么工作(各阶段;端到端 vs 流水线;声码器;流式/分块);voicebox 的 7 个引擎 + 怎么选
      _达标证据_:能给别人讲清 TTS 架构、能为某需求给出引擎选型理由。
- [ ] ◇ **M6 — 声音克隆** · 从参考样本零样本克隆;说话人嵌入;接克隆端点
      _达标证据_:几秒音频克隆一个声音、用它出声。
- [ ] ◇ **M7 — 听写输入(STT)** · 本地语音转写、全局热键捕获、听写到任意 app(WisprFlow 那一半)
      _达标证据_:用热键把话听写到另一个 app,全本地。
- [ ] ◇ **M8 — 后处理 + 内置 LLM** · 音频特效链(变调/混响/…);内置本地 LLM 做转写/演绎精修 + MCP agent 发声
      _达标证据_:串一个音频特效;TTS 前先把文本过一遍 LLM。
- [ ] ◇ **M9 — 打包分发** · PyInstaller 打 sidecar + `tauri build` → 一个捆绑模型的 Mac 应用
      _达标证据_:一个朋友能在他自己 Mac 上跑的 `.dmg`/安装包。
- [ ] ◇ **M10 — 毕业项目** · 不开 voicebox,从零搭一个最小语音 I/O 应用(克隆 + TTS + 听写)
      _达标证据_:应用能跑,且是你自己写的。

## 下一步

M1 —— 第 1 课是架构图 + 首次跑通。把仓库弄到机器上、起 dev 环境,确认能看到应用窗口 + 画出 sidecar 图。这会把"我到底在看什么"这个问题,为后面每一课提前解决。
