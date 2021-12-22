" 行番号表示
set number

" バックアップファイルを作らない
set nobackup

" スワップファイルを作らない
set noswapfile

" カーソルラインをハイライト
set cursorline

" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-

" Tab文字を半角スペースにする
set expandtab

" Tabサイズ
set tabstop=4

" 自動インテントサイズ
set shiftwidth=4

" 文字コードをUTF-8にする
set fenc=utf-8

" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore

" ビープ音を無効化
set novisualbell

" ステータスラインを常に表示
set laststatus=2

" コマンドラインの補完
set wildmode=list:longest

" シンタックスハイライトの有効化
syntax enable

" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase

" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase

" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch

" 検索時に最後まで行ったら最初に戻る
set wrapscan

" 検索語をハイライト表示
set hlsearch

" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
