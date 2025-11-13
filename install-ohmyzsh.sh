#!/bin/bash

# 安装 oh-my-zsh 脚本

set -e

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OHMYZSH_SOURCE="$SCRIPT_DIR/ohmyzsh"
ZSHRC_SOURCE="$SCRIPT_DIR/.zshrc"

# 检查源文件是否存在
if [ ! -d "$OHMYZSH_SOURCE" ]; then
    echo "错误: 找不到 ohmyzsh 目录: $OHMYZSH_SOURCE"
    exit 1
fi

if [ ! -f "$ZSHRC_SOURCE" ]; then
    echo "错误: 找不到 .zshrc 文件: $ZSHRC_SOURCE"
    exit 1
fi

# 目标路径
OHMYZSH_TARGET="$HOME/.config/ohmyzsh"
ZSHRC_TARGET="$HOME/.zshrc"

# 创建 ~/.config 目录（如果不存在）
mkdir -p "$HOME/.config"

# 处理 ohmyzsh 目录
if [ -d "$OHMYZSH_TARGET" ]; then
    echo "警告: $OHMYZSH_TARGET 已存在"
    read -p "是否备份现有目录？(y/n): " backup_ohmyzsh
    if [ "$backup_ohmyzsh" = "y" ] || [ "$backup_ohmyzsh" = "Y" ]; then
        BACKUP_OHMYZSH="${OHMYZSH_TARGET}.backup.$(date +%Y%m%d_%H%M%S)"
        echo "备份到: $BACKUP_OHMYZSH"
        mv "$OHMYZSH_TARGET" "$BACKUP_OHMYZSH"
        echo "复制 ohmyzsh 目录到 $OHMYZSH_TARGET"
        cp -r "$OHMYZSH_SOURCE" "$OHMYZSH_TARGET"
        echo "✓ ohmyzsh 安装完成"
    else
        echo "跳过 ohmyzsh 安装"
    fi
else
    echo "复制 ohmyzsh 目录到 $OHMYZSH_TARGET"
    cp -r "$OHMYZSH_SOURCE" "$OHMYZSH_TARGET"
    echo "✓ ohmyzsh 安装完成"
fi

# 处理 .zshrc 文件
if [ -f "$ZSHRC_TARGET" ]; then
    echo "警告: $ZSHRC_TARGET 已存在"
    read -p "是否备份现有文件？(y/n): " backup_zshrc
    if [ "$backup_zshrc" = "y" ] || [ "$backup_zshrc" = "Y" ]; then
        BACKUP_ZSHRC="${ZSHRC_TARGET}.backup.$(date +%Y%m%d_%H%M%S)"
        echo "备份到: $BACKUP_ZSHRC"
        cp "$ZSHRC_TARGET" "$BACKUP_ZSHRC"
        echo "复制 .zshrc 到 $ZSHRC_TARGET"
        cp "$ZSHRC_SOURCE" "$ZSHRC_TARGET"
        echo "✓ .zshrc 安装完成"
    else
        echo "跳过 .zshrc 安装"
    fi
else
    echo "复制 .zshrc 到 $ZSHRC_TARGET"
    cp "$ZSHRC_SOURCE" "$ZSHRC_TARGET"
    echo "✓ .zshrc 安装完成"
fi

echo ""
echo "安装完成！"
echo "ohmyzsh 位置: $OHMYZSH_TARGET"
echo ".zshrc 位置: $ZSHRC_TARGET"
echo ""
echo "请运行以下命令切换到 zsh:"
echo "  zsh"

