# voicebox Resources

Curated, high-trust sources for this course. Knowledge for explainers comes from here, not parametric guesses. Annotate every entry with what it covers and when to reach for it.

> **Verification note**: the engine **names** below come straight from voicebox's README (verified). Specific repo/project URLs are marked `(verify)` — confirm them via the `web-access` skill the first time you cite one in a lesson. The voicebox repo + its in-tree `docs/` + `backend/README.md` are the primary source for the architecture layers; lean on them before reaching outward.

## Knowledge — the project itself (highest trust for architecture)

- [voicebox repo — jamiepine/voicebox](https://github.com/jamiepine/voicebox)
  The reference implementation. Use for: every architecture layer — `app/` (React UI), `tauri/` + `tauri/src-tauri/` (Rust shell), `backend/` (FastAPI sidecar), the sidecar build (`scripts/setup-dev-sidecar.js`, `backend/build_binary.py`, `backend/voicebox-server.spec`).
- [docs.voicebox.sh](https://docs.voicebox.sh) — `overview/`, `developer/`, `api-reference/` (+ in-tree `docs/content/docs/`)
  The narrative docs. Use for: the intended mental model + the FastAPI endpoint surface (there's an `openapi.json` in-tree → generated API reference).
- `backend/README.md` + `backend/STYLE_GUIDE.md` (in-tree)
  Use for: how the Python sidecar is structured and how it expects to be written.

## Knowledge — the layers (general, high-trust)

- [Tauri docs — tauri.app](https://tauri.app)
  Use for: M2 (shell, IPC, commands), and crucially the **Sidecar** + **Process / shell** plugins (how voicebox spawns the Python binary). Also `tauri build` for M9.
- [FastAPI docs — fastapi.tiangolo.com](https://fastapi.tiangolo.com)
  Use for: M3 (the sidecar API surface; routes; streaming responses for audio).
- [uvicorn](https://www.uvicorn.org) — the ASGI server voicebox uses (`uvicorn backend.main:app --port 17493`).
- [SQLAlchemy](https://docs.sqlalchemy.org) — voicebox's DB layer (`backend/database/`).
- [PyInstaller](https://pyinstaller.org) — how the Python sidecar becomes a single bundled binary (M9). See `backend/build_binary.py`.

## Knowledge — audio models (deploy + principles, Apple Silicon)

- [MLX — apple/mlx](https://github.com/ml-explore/mlx) `(verify)` + voicebox's `backend/requirements-mlx.txt`
  Use for: running models on Apple Silicon efficiently (M4 deployment target). voicebox ships an MLX requirements file — that's your Mac path.
- [Kokoro TTS](https://github.com/hexgrad/kokoro) `(verify)`
  Use for: M4 — the lightest first model to stand up (fast, Mac-friendly, good quality). Your first end-to-end TTS.
- [Chatterbox — letta-ai/chatterbox](https://github.com/letta-ai/chatterbox) `(verify)` · [Qwen3-TTS](https://github.com/QwenLM/Qwen3-TTS) `(verify)` · HumeAI TADA
  The other engines voicebox bundles (the README lists 7). Use for: M5 engine-landscape + expressiveness (Chatterbox Turbo's paralinguistic `[laugh]`/`[sigh]` tags, Qwen CustomVoice delivery control).
- [huggingface_hub](https://huggingface.co/docs/huggingface_hub) — how voicebox fetches model weights.
- librosa / soundfile / torch audio I/O — for chunking, crossfade, the post-processing FX chain (M8).
- _TTS principles (M5)_ — when you reach M5, surface a high-trust explainer on end-to-end TTS (e.g. VITS) vs pipeline (tokenizer → acoustic → vocoder) via `web-access`. Add it here once verified.

## Wisdom (communities)

- voicebox GitHub Discussions / Issues + Discord (if linked from the repo) — the canonical place for "why is X structured this way."
- r/LocalLLaMA, r/TTS, Hugging Face Spaces — the broader local-audio-on-Mac practitioner scene. Use for: engine comparisons, Mac/MPS/MLX gotchas, plateau troubleshooting.

## Gaps

- A single grounded "how TTS works, for practitioners" explainer (not a paper) — to find at M5.
- The exact MLX-vs-MPS-vs-CPU decision voicebox makes per engine on Apple Silicon — to extract from `backend/` during M4.
