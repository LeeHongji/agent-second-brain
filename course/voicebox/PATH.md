# Path: voicebox — build a local AI voice app from scratch

**Status**: in-progress
**Mission**: [[MISSION.md]]
**Last revised**: 2026-06-30

## Direction

You start from what you know (React/TS) and climb the stack one layer at a time: first **see the whole** and get voicebox running, then the **Tauri shell** (the new layer nearest the web you know), then the **Python FastAPI sidecar**, then **serving local models** on your Mac. Once the pipeline speaks (TTS), you go **horizontal into the voice domain** — TTS principles, cloning, dictation (STT), effects + the bundled LLM — and finally **vertical into shipping**: packaging the sidecar + Tauri into a distributable Mac app, capped by a from-scratch capstone. Each milestone ends with something you can run or explain; each new layer is adjacent to one you just earned.

## Milestones

- [~] ▶ **M1 — Orient & run** · the sidecar architecture + get voicebox running in dev on your Mac
      _Evidence needed_: you can draw the React→Tauri→FastAPI-sidecar→models map from memory, and the dev app launches on your machine.
- [ ] ◇ **M2 — The Tauri shell** · Rust+web IPC, window/tray/hotkey, spawning a child process (the sidecar seed)
      _Evidence needed_: a hello-Tauri app hosting a React UI that launches a child process and reads its stdout.
- [ ] ◇ **M3 — The Python FastAPI sidecar** · FastAPI basics, `backend/` structure (routes/services/backends), HTTP Tauri→Python
      _Evidence needed_: a Tauri button that calls a local FastAPI endpoint and renders the result in the UI.
- [ ] ◇ **M4 — Serve your first local model (TTS)** · load Kokoro via torch/MLX on Apple Silicon, expose `/tts`, stream audio back
      _Evidence needed_: type text in the UI → hear it speak, end-to-end, on your Mac.
- [ ] ◇ **M5 — TTS principles + engine landscape** · how TTS works (stages; end-to-end vs pipeline; vocoders; streaming/chunking); the 7 voicebox engines + when to pick which
      _Evidence needed_: you can explain TTS architecture to someone and justify an engine choice for a given requirement.
- [ ] ◇ **M6 — Voice cloning** · zero-shot cloning from a reference sample; speaker embeddings; wire a clone endpoint
      _Evidence needed_: clone a voice from a few seconds of audio and generate speech in it.
- [ ] ◇ **M7 — Dictation input (STT)** · local speech-to-text, global hotkey capture, dictate-into-any-app (the WisprFlow half)
      _Evidence needed_: dictate into another app via a hotkey, fully locally.
- [ ] ◇ **M8 — Post-processing + bundled LLM** · audio FX chain (pitch/reverb/…); the bundled local LLM for transcript/delivery refinement + MCP agent voice
      _Evidence needed_: chain an audio effect; route text through the LLM before TTS.
- [ ] ◇ **M9 — Package & distribute** · PyInstaller sidecar build + `tauri build` → a Mac app bundling the models
      _Evidence needed_: a `.dmg`/installer a friend can run on their Mac.
- [ ] ◇ **M10 — Capstone** · build a minimal voice I/O app from scratch (clone + TTS + dictate) without voicebox open
      _Evidence needed_: the app works; you wrote it yourself.

## Next

M1 — Lesson 1 is the architecture map + first run. Get the repo on your machine, start the dev environment, and confirm you can see the app window + draw the sidecar diagram. That fixes the "what am I even looking at" question for every later lesson.
