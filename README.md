# コラボハウス Claude Code 共通設定

社員全員が使う Claude Code の設定を管理するリポジトリです。

## セットアップ

初回のみ、VS Codeのターミナルで以下をコピペして実行してください：

```
irm https://raw.githubusercontent.com/n-matsusaka/claude-config/master/setup.ps1 | iex
```

これで以下が自動的に配置されます：
- `~/.claude/CLAUDE.md` — 社員共通ルール
- `~/.claude/skills/` — 共通スキル（new-project等）
- `~/_template/` — プロジェクトテンプレート（hooks, settings.json等）

## 新プロジェクトの作り方

Claude Code で「新プロジェクト作って」と言うだけでOKです。
最新の設定とテンプレートがGitHubから自動で取得されます。

## 設定を最新化したい場合

上記のコマンドを再度実行してください。
