.PHONY: all clean help

# デフォルトターゲット
all: typeset

# 組版の実行
typeset:
	@echo "組版処理を開始します..."
	@ruby typesetter.rb

# クリーンアップ
clean:
	@echo "生成ファイルを削除します..."
	@rm -f TeXfile/*.tex
	@rm -f output/*.pdf output/*.aux output/*.log output/*.out output/*.toc output/*.synctex.gz
	@echo "削除完了"

# ヘルプ
help:
	@echo "利用可能なコマンド:"
	@echo "  make         - 組版処理を実行"
	@echo "  make typeset - 組版処理を実行"
	@echo "  make clean   - 生成されたファイルを削除"
	@echo "  make help    - このヘルプを表示"
