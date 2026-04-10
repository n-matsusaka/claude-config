# claude-config

コラボハウス社員共通の Claude Code 設定ファイル。

## セットアップ

初回のみ、以下を実行してください：

```bash
# 1. このリポジトリをクローン
git clone https://github.com/n-matsusaka/claude-config.git ~/claude-config

# 2. CLAUDE.md を ~/.claude/ にコピー
cp ~/claude-config/CLAUDE.md ~/.claude/CLAUDE.md

# 3. スキルをコピー
cp -r ~/claude-config/skills/* ~/.claude/skills/
```

## 更新方法

松坂がルールを更新した場合、以下で最新版を取得できます：

```bash
cd ~/claude-config && git pull origin main
cp ~/claude-config/CLAUDE.md ~/.claude/CLAUDE.md
cp -r ~/claude-config/skills/* ~/.claude/skills/
```

※ new-projectスキルを使うと、プロジェクト作成時に自動で最新化されます。
