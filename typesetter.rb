#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

require 'fileutils'

class AutomaticalTypesetter
  def initialize
    @input_dir = 'input'
    @texfile_dir = 'TeXfile'
    @output_dir = 'output'
    @master_tex = 'master.tex'
  end

  def run
    puts "文芸誌組版自動化システムを開始します..."
    
    # ディレクトリの確認
    check_directories
    
    # MDファイルをLaTeXに変換
    convert_md_to_latex
    
    # マスターファイルをコンパイル
    compile_master
    
    puts "処理が完了しました！"
  end

  private

  def check_directories
    [@input_dir, @texfile_dir, @output_dir].each do |dir|
      unless Dir.exist?(dir)
        Dir.mkdir(dir)
        puts "#{dir}ディレクトリを作成しました"
      end
    end
  end

  def convert_md_to_latex
    md_files = Dir.glob(File.join(@input_dir, '*.md'))
    
    if md_files.empty?
      puts "警告: #{@input_dir}ディレクトリにMDファイルがありません"
      return
    end
    
    md_files.each do |md_file|
      basename = File.basename(md_file, '.md')
      tex_file = File.join(@texfile_dir, "#{basename}.tex")
      
      puts "変換中: #{md_file} -> #{tex_file}"
      
      # pandocコマンドを実行
      cmd = "pandoc -f markdown -t latex --pdf-engine=lualatex #{md_file} -o #{tex_file}"
      system(cmd)
      
      if $?.success?
        puts "  成功: #{tex_file}を作成しました"
      else
        puts "  警告: pandocが利用できません。手動で変換してください。"
        puts "  コマンド: #{cmd}"
      end
    end
  end

  def compile_master
    unless File.exist?(@master_tex)
      puts "警告: #{@master_tex}が見つかりません"
      return
    end
    
    puts "マスターファイルをコンパイル中..."
    
    # LaTeXコンパイル（2回実行して目次等を確定）
    2.times do |i|
      cmd = "lualatex -output-directory=#{@output_dir} #{@master_tex}"
      system(cmd)
      
      unless $?.success?
        puts "  警告: LaTeXコンパイラが利用できません。"
        puts "  コマンド: #{cmd}"
        return
      end
    end
    
    output_pdf = File.join(@output_dir, 'master.pdf')
    if File.exist?(output_pdf)
      puts "  成功: #{output_pdf}を作成しました"
    end
  end
end

# スクリプトとして実行された場合
if __FILE__ == $0
  typesetter = AutomaticalTypesetter.new
  typesetter.run
end
