# Mission: Build a voicebox-style local AI voice app from scratch

## Why

I want to be able to build a **local-first AI voice application** — desktop app that runs voice models (TTS, voice cloning, speech-to-text dictation) on my own machine, bundled and distributable — starting from the reference example of `jamiepine/voicebox`. The concrete outcome: I can sit down with an empty folder and produce a working voice I/O app without copying voicebox, because I understand every layer of how it's built.

## Success looks like

- I can scaffold a **Tauri** desktop app that hosts a React UI and launches a **Python FastAPI sidecar** over a local port.
- I can **serve a local TTS model on Apple Silicon** (torch / MLX) via an API endpoint and stream the audio back into the UI — type text, hear it speak.
- I can **clone a voice** from a few seconds of reference audio and generate speech in that voice.
- I can wire **dictation input** (local STT + a global hotkey) that types into other apps.
- I can **explain, not just run** how TTS and voice cloning work at an architecture level, so I can pick between engines (Kokoro vs Chatterbox vs Qwen3-TTS …) for a given need.
- I can **package** the whole thing (Python sidecar via PyInstaller + `tauri build`) into a Mac app someone else can install.
- **Capstone**: ship a minimal from-scratch voice I/O app (clone + TTS + dictate) without the voicebox codebase open.

## Constraints

- **Machine**: Mac (Apple Silicon, M-series). Model deployment targets MPS / MLX — not CUDA/ROCm (those come up only as "how voicebox supports them").
- **Depth**: deploy + understand principles. **No ML training or fine-tuning.** I use existing open-weight models; I learn how they fit together and how to serve them, not how to train them.
- **Beachhead**: I already know **React / TypeScript**. The front-end is my way in; Rust/Tauri, Python backend, and local-model serving are the three new layers to build up.
- Time: multi-session, at my own pace (this is a stateful course, not a one-shot).

## Out of scope

- Training / fine-tuning voice models, ML theory below the architecture level, dataset prep.
- Non-Mac deployment deep-dives (CUDA build flags, ROCm) — covered conceptually only.
- The marketing landing page (`landing/`) and the docs site (`docs/`) as build targets.
- Voicebox's full long-tail features (every effect, every language) — learn the pattern, not the exhaustive list.
