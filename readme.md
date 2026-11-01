# zsh config: fast startup, no framework

My personal zsh setup for macOS. Same comfort as my old oh-my-zsh setup (theme, fuzzy finder, autosuggestions, syntax highlighting, completions, nvm), a fraction of the startup time.

**Shell startup: 2,342 ms → 44 ms**, measured with `zprof` on a MacBook Pro 2015 (macOS 12).

| Setup | Startup time |
|---|---|
| oh-my-zsh + fzf, nvm, autosuggestions, syntax highlighting, interactive-cd | 2,342 ms |
| This config, nvm loaded at startup | 1,217 ms |
| This config, nvm lazy-loaded, completion dump not compiled | ~375 ms |
| **This config, current version** | **44 ms** (1,316 ms once a day, when the completion cache is rebuilt) |

The full measurement log, step by step, is in [docs/benchmarks.md](docs/benchmarks.md).

## What made the difference

1. **No framework.** Plugins are git submodules, sourced directly. Nothing else is loaded.
2. **nvm is lazy-loaded.** Loading nvm at startup cost about 1 second. Now `node`, `npm` and `nvm` are small autoloaded functions that load nvm on first use, then replace themselves.
3. **The completion dump is rebuilt once a day and compiled.** `compinit` re-parsing about 1,000 `compdef` calls on every start was the next bottleneck. The dump is now regenerated when older than 24 hours, then compiled to bytecode with `zcompile`. Other starts use `compinit -C` on the compiled file: about 6 ms instead of 25.
4. **fzf's shell integration is cached.** `source <(fzf --zsh)` launched the fzf binary on every start for output that only changes with fzf itself. It is now generated once, compiled, and regenerated only when the fzf binary changes.
5. **No needless subprocesses.** For example, the cache directory is only created when it doesn't exist yet.

### A bug worth knowing

The once-a-day logic first never worked. The staleness check uses a glob qualifier, `$ZSH_COMPDUMP(#qN.mh+24)`, which zsh silently ignores unless `setopt extendedglob` is on. The test was always false, so the dump was never compiled. On top of that, the fallback `compinit -C` was missing `-d $ZSH_COMPDUMP` and wrote its cache to `~` instead of the cache directory. Fixing both took startup from about 75 ms to 44 ms.

## What's included

- **Theme:** [agnoster](https://github.com/agnoster/agnoster-zsh-theme) (needs a Powerline-compatible font)
- **Plugins:** [fzf](https://github.com/junegunn/fzf), [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions), [fast-syntax-highlighting](https://github.com/zdharma-continuum/fast-syntax-highlighting), [zsh-completions](https://github.com/zsh-users/zsh-completions), git completion
- **History:** shared between sessions, duplicates removed, 10,000 entries
- **Directories:** `auto_cd`, directory stack (`cd -1`, `cd -2`…)
- **Functions** (autoloaded, one file per function): `mkcd`, `kill_port`, lazy `node` / `npm` / `nvm`
- **Aliases:** safe `rm` / `cp` / `mv`, and a few personal shortcuts

## Install

```bash
git clone --recurse-submodules https://github.com/mistergraphx/zsh.git ~/path/to/zsh
```

Then in `~/.zshrc`:

```bash
# Set to 1 to print a zprof report and the startup time
export PROFILING_MODE=0

source ~/path/to/zsh/main.zsh
```

`env.zsh` contains macOS paths specific to my machine (Homebrew, MacPorts, MAMP): adapt them to yours.

## Measure it yourself

Set `PROFILING_MODE=1` and open a new terminal: you get the `zprof` report and the startup time in milliseconds. Run it a few times, since the first start after a change (or once a day) rebuilds the caches.

## Structure

```
main.zsh        entry point: options, theme, plugins, completion, profiling
env.zsh         PATH and environment
aliases.zsh     aliases
functions/      autoloaded functions, one per file
plugins/        git submodules (+ git completion)
themes/         git submodule (agnoster)
.cache/         history, completion dump, fzf cache (generated)
```

## Sources

- [zsh options reference](https://zsh.sourceforge.io/Doc/Release/Options.html)
- [Optimizing zsh startup performance](https://santacloud.dev/posts/optimizing-zsh-startup-performance/)
- [Some pearls from my zshrc](https://dev.to/voyeg3r/some-pearls-from-my-zshrc-282m) (lazy-loading nvm)
