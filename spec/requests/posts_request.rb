require 'rails_helper'

describe '投稿のテスト' do
  @post = FactoryBot.create(:post)
  describe "[Action test]" do
    before do
      @user = FactoryBot.create(:user)
    end
    #newアクション
    context "new" do
      it "access by user" do
        sign_in @user
        get '/posts/new'
        expect(response).to be_successful
      end
    end
  end
  describe "index" do
    #未ログインユーザーの場合
    context "as a user not to login" do
      # indexアクション後ログインページへ遷移
      it "redirects to the sign-in page" do
        get '/posts'
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "show" do
    #未ログインユーザーの場合
    context "as a user not to login" do
      # showアクション後ログインページへ遷移
      it "redirects to the sign-in page" do
        get '/posts/:id'
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "show" do
    #未ログインユーザーの場合
    context "as a user not to login" do
      # showアクション後ログインページへ遷移
      it "redirects to the sign-in page" do
        get '/posts/:id'
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "followed_index" do
    #未ログインユーザーの場合
    context "as a user not to login" do
      # showアクション後ログインページへ遷移
      it "redirects to the sign-in page" do
        get '/posts/followed_index'
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe "edit" do
    #未ログインユーザーの場合
    context "as a user not to login" do
      # showアクション後ログインページへ遷移
      it "redirects to the sign-in page" do
        get '/posts/:id/edit'
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  
  describe 'ログイン後のテスト' do
    before do
      @user = FactoryBot.create(:user)
      sign_in @user
    end
    describe 'トップ画面(root_path)のテスト' do
      before do 
        visit root_path
      end
      context '表示の確認' do
        it 'トップ画面(root_path)にフォロワーの投稿一覧ページへのリンクが表示されているか' do
          expect(page).to have_link "", href: posts_index_path
        end
        it 'トップ画面(root_path)に全ユーザーの投稿一覧ページへのリンクが表示されているか' do
          expect(page).to have_link "", href: posts_path
        end
        it 'トップ画面(root_path)に通知一覧へのリンクが表示されているか' do
          expect(page).to have_link "", href: notifications_path
        end
        it 'トップ画面(root_path)にマイページへのリンクが表示されているか' do
          expect(page).to have_link "", href: user_path(@user)
        end
        it 'トップ画面(root_path)に新規投稿へのリンクが表示されているか' do
          expect(page).to have_link "", href: new_post_path
        end
        it 'トップ画面(root_path)にキャンプサイト一覧へのリンクが表示されているか' do
          expect(page).to have_link "", href: regions_path
        end
        it 'トップ画面(root_path)にログアウトへのリンクが表示されているか' do
          expect(page).to have_link "", href: destroy_user_session_path
        end
        it 'root_pathが"/"であるか' do
          expect(current_path).to eq('/')
        end
      end
    end
    describe "一覧画面のテスト" do
      before do
        visit posts_path
      end
      context '一覧の表示とリンクの確認' do
        it "postの画像とユーザー名を表示し、showリンクが表示されているか" do
            (1..5).each do |i|
              FactoryBot.create(:post)
            end
            visit posts_path
            Post.all.each_with_index do |post,i|
              j = i * 3
              expect(page).to have_content post.image
              expect(page).to have_content post.body
              # Showリンク
              show_link = find_all('a')[j]
              expect(show_link.native.inner_text).to match(/show/i)
              expect(show_link[:href]).to eq book_path(book)
            end
        end
        it 'Create Bookボタンが表示される' do
          expect(page).to have_button '投稿する'
        end
      end
      context '投稿処理に関するテスト' do 
        it '投稿に成功しサクセスメッセージが表示されるか' do
          click_button '投稿する'
          expect(page).to have_content '投稿しました'
        end
        it '投稿に失敗する' do
          click_button '投稿する'
          expect(page).to have_content 'error'
          expect(current_path).to eq('/posts/:id')
        end
        it '投稿後のリダイレクト先は正しいか' do
          fill_in 'post[body]', with: Faker::Lorem.characters(number:20)
          click_button '投稿する'
          expect(page).to have_current_path book_path(Post.last)
        end
      end
      context 'book削除のテスト' do
        it 'bookの削除' do
          expect{ book.destroy }.to change{ Book.count }.by(-1)
          # ※本来はダイアログのテストまで行うがココではデータが削除されることだけをテスト
        end
      end
    end
    describe '詳細画面のテスト' do
      before do
        visit book_path(book)
      end
      context '表示の確認' do
        it '本のタイトルと感想が画面に表示されていること' do
          expect(page).to have_content book.title
          expect(page).to have_content book.body
        end
        it 'Editリンクが表示される' do
          edit_link = find_all('a')[0]
          expect(edit_link.native.inner_text).to match(/edit/i)
  			end
        it 'Backリンクが表示される' do
          back_link = find_all('a')[1]
          expect(back_link.native.inner_text).to match(/back/i)
  			end  
      end
      context 'リンクの遷移先の確認' do
        it 'Editの遷移先は編集画面か' do
          edit_link = find_all('a')[0]
          edit_link.click
          expect(current_path).to eq('/books/' + book.id.to_s + '/edit')
        end
        it 'Backの遷移先は一覧画面か' do
          back_link = find_all('a')[1]
          back_link.click
          expect(page).to have_current_path books_path
        end
      end
    end
    describe '編集画面のテスト' do
      before do
        visit edit_book_path(book)
      end
      context '表示の確認' do
        it '編集前のタイトルと感想がフォームに表示(セット)されている' do
          expect(page).to have_field 'book[title]', with: book.title
          expect(page).to have_field 'book[body]', with: book.body
        end
        it 'Update Bookボタンが表示される' do
          expect(page).to have_button 'Update Book'
        end
        it 'Showリンクが表示される' do
          show_link = find_all('a')[0]
          expect(show_link.native.inner_text).to match(/show/i)
  			end  
        it 'Backリンクが表示される' do
          back_link = find_all('a')[1]
          expect(back_link.native.inner_text).to match(/back/i)
  			end  
      end
      context 'リンクの遷移先の確認' do
        it 'Showの遷移先は詳細画面か' do
          show_link = find_all('a')[0]
          show_link.click
          expect(current_path).to eq('/books/' + book.id.to_s)
        end
        it 'Backの遷移先は一覧画面か' do
          back_link = find_all('a')[1]
          back_link.click
          expect(page).to have_current_path books_path
        end
      end
      context '更新処理に関するテスト' do
        it '更新に成功しサクセスメッセージが表示されるか' do
          fill_in 'book[title]', with: Faker::Lorem.characters(number:5)
          fill_in 'book[body]', with: Faker::Lorem.characters(number:20)
          click_button 'Update Book'
          expect(page).to have_content 'successfully'
        end
        it '更新に失敗しエラーメッセージが表示されるか' do
          fill_in 'book[title]', with: ""
          fill_in 'book[body]', with: ""
          click_button 'Update Book'
          expect(page).to have_content 'error'
        end
        it '更新後のリダイレクト先は正しいか' do
          fill_in 'book[title]', with: Faker::Lorem.characters(number:5)
          fill_in 'book[body]', with: Faker::Lorem.characters(number:20)
          click_button 'Update Book'
          expect(page).to have_current_path book_path(book)
        end
      end
    end
  end
end