#!/bin/bash
# コラボハウス Claude Code 初期セットアップスクリプト
# 新入社員が1回実行するだけで環境が整います
#
# 使い方（Claude Codeに実行してもらう）:
#   curl -sL https://raw.githubusercontent.com/n-matsusaka/claude-config/master/setup.sh | bash

set -e

echo "=== コラボハウス Claude Code セットアップ ==="
echo ""

# 1. ~/.claude ディレクトリの作成
mkdir -p "$HOME/.claude/skills"
echo "[1/4] ~/.claude ディレクトリを確認しました"

# 2. claude-config をクローンまたは最新化
if [ -d "$HOME/claude-config" ]; then
  echo "[2/4] claude-config を最新化中..."
  cd "$HOME/claude-config" && git pull origin master
else
  echo "[2/4] claude-config をクローン中..."
  git clone https://github.com/n-matsusaka/claude-config.git "$HOME/claude-config"
fi

# 3. claude-template をクローンまたは最新化
if [ -d "$HOME/_template" ]; then
  echo "[3/4] claude-template を最新化中..."
  cd "$HOME/_template" && git pull origin master
else
  echo "[3/4] claude-template をクローン中..."
  git clone https://github.com/n-matsusaka/claude-template.git "$HOME/_template"
fi

# 4. グローバル設定を配置
echo "[4/4] グローバル設定を配置中..."
cp "$HOME/claude-config/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
cp -r "$HOME/claude-config/skills/"* "$HOME/.claude/skills/" 2>/dev/null || true

echo ""
echo "=== セットアップ完了 ==="
echo ""
echo "配置されたファイル:"
echo "  ~/.claude/CLAUDE.md        — 社員共通ルール"
echo "  ~/.claude/skills/          — 共通スキル（new-project等）"
echo "  ~/_template/               — プロジェクトテンプレート"
echo ""
echo "新しいプロジェクトを作るときは:"
echo "  Claude Codeで「新プロジェクト作って」と言うだけでOKです。"
echo "  最新の設定とテンプレートが自動で使われます。"
