class BooksController < ApplicationController
  def new
   #モデルオブジェクトを生成するためにコントローラでインスタンス変数を定義した
   @book = Book.new
  end

  def create
   #データを受け取り新規登録するためのインスタンス作成
   #ローカル変数はビューファイルに受け渡しができない。アクション内でしか利用できない。
   @book = Book.new(book_params)

   #データをデータベースに保存するためのsaveメソッド実行
   if @book.save
   #成功した時のメッセージ(フラッシュメッセージ)
   flash[:notice] = "Book was successfully created."

   #リダイレクトさせるURLを指定。Prefix名_path(book.id)
   redirect_to book_path(@book.id)
   else
    #バリデーション 空欄の時のメッセージ（空欄の条件はmodels/book.rbに記述）ビューにエラーメッセージを記事。
    #ビューに対応（表示）させたい記述があるので、ローカル変数だったbookをインスタンス変数に変えた。
    @books = Book.all
    render :index
   end
  end

  def index
    #Bookからallメソッドを呼び出しているので、booksテーブルに保存されている全てのデータを取得することができる。
    @books = Book.all
    @book = Book.new
  end

  def show
    #レコードを1件だけ取得するので、インスタンス変数名は単数形の「@book」にする
    #findメソッドは引数を受け取り、idカラムを引数と比べてレコードを取得してくるメソッド。
    #詳細画面で呼び出される投稿データは、URLの/books/:id内の:idで判別される。 この:idは、アクション内にparams[:id]と記述することで取得できる。
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
   #updateアクションは、データの更新後に更新結果を詳細画面に表示するためにshowアクションにリダイレクトさせる。このため、新たなビューは作成しない。
   #showアクションにリダイレクトするために、引数には必ずidが必要になる。idを付けることでどのデータを詳細画面で表示させるのかを決定している。
   @book = Book.find(params[:id])
   if @book.update(book_params)
   #成功した時のメッセージ
   flash[:notice] = "Book was successfully updated."
   redirect_to book_path
   else
    #空欄の時のメッセージ（空欄の条件はmodels/book.rbに記述）ビューにエラーメッセージを記事。
    #ビューに対応（表示）させたい記述があるので、ローカル変数だったbookをインスタンス変数に変えた。
    render :edit
   end
  end

  def destroy
   # データ（レコード）を1件取得
   @book = Book.find(params[:id])
   # データ（レコード）を削除
   @book.destroy
   # 投稿一覧画面へリダイレクト なぜ投稿画面に行けるのか
   redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
  #privateメソッドの名前は、「モデル名_params」とすることが多い。
  #params　formから送られてくるデータはparamsの中に入っている。
  #require 送られてきたデータの中からモデル名(:book)を指定し、データを絞り込む
  #permit　requireで絞り込んだデータの中から、保存を許可するカラムを指定する。


  #book_paramsについて後で確認
  #(params[:id])について後で確認
