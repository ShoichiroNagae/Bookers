class BooksController < ApplicationController
  # 投稿された本の一覧と新規投稿
  def index
    @books = Book.all
    @book = Book.new
  end

  # 新しい本を登録する
  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      # render :遷移したいhtmlファイル名 で遷移する
      @books = Book.all
      render :index
    end
  end

  def show
    # 1件のみの取得なので，単数形で宣言
    @book = Book.find(params[:id])
    # コントローラー専用
    # 対応するviewがない場合


  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      # 保存に成功した場合
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      # 保存に失敗した場合
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])  # データ（レコード）を1件取得
    book.destroy  # データ（レコード）を削除
    redirect_to '/books'  # 投稿一覧画面へリダイレクト
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
