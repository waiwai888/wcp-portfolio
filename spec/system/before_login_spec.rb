require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'Log inリンクが表示される: 左上から5番目のリンクが「Log in」である' do
        log_in_link = find_all('a')[5].native.inner_text
        expect(log_in_link).to match(/ログイン/i)
      end
      it 'Log inリンクの内容が正しい' do
        log_in_link = find_all('a')[5].native.inner_text
        expect(page).to have_link log_in_link, href: new_user_session_path
      end
      it 'Sign Upリンクが表示される: 左上から4番目のリンクが「Sign Up」である' do
        sign_up_link = find_all('a')[4].native.inner_text
        expect(sign_up_link).to match(/新規登録/i)
      end
      it 'Sign Upリンクの内容が正しい' do
        sign_up_link = find_all('a')[4].native.inner_text
        expect(page).to have_link sign_up_link, href: new_user_registration_path
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'Aboutリンクが表示される: 左上から1番目のリンクが「Campistについて」である' do
        home_link = find_all('a')[1].native.inner_text
        expect(home_link).to match("Campistについて")
      end
      it 'Featureリンクが表示される: 左上から2番目のリンクが「どんなサービス？」である' do
        home_link = find_all('a')[2].native.inner_text
        expect(home_link).to match("どんなサービス？")
      end
      it 'Contactリンクが表示される: 左上から3番目のリンクが「お問い合わせ」である' do
        home_link = find_all('a')[3].native.inner_text
        expect(home_link).to match("お問い合わせ")
      end
      it 'sign upリンクが表示される: 左上から4番目のリンクが「新規登録」である' do
        signup_link = find_all('a')[4].native.inner_text
        expect(signup_link).to match("新規登録")
      end
      it 'loginリンクが表示される: 左上から5番目のリンクが「ログイン」である' do
        login_link = find_all('a')[5].native.inner_text
        expect(login_link).to match("ログイン")
      end
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it 'Homeを押すと、トップ画面に遷移する' do
        home_link = find_all('a')[1].native.inner_text
        home_link = home_link.delete(' ')
        home_link.gsub!(/\n/, '')
        click_link home_link
        is_expected.to eq '/'
      end
      it 'sign upを押すと、新規登録画面に遷移する' do
        signup_link = find_all('a')[4].native.inner_text
        signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signup_link
        is_expected.to eq '/users/sign_up'
      end
      it 'loginを押すと、ログイン画面に遷移する' do
        login_link = find_all('a')[5].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link
        is_expected.to eq '/users/sign_in'
      end
    end
  end

  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it '「新規登録」と表示される' do
        expect(page).to have_content '新規登録'
      end
      it 'nameフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it 'Sign upボタンが表示される' do
        expect(page).to have_button '新規登録（無料）'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[nickname]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[account_name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button '新規登録（無料）' }.to change(User.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、フォローユーザーの投稿一覧ページになっている' do
        click_button '新規登録（無料）'
        expect(current_path).to eq '/posts/followed_index'
      end
    end
  end

  describe 'ユーザログイン' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'Log inボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、フォローユーザーの投稿一覧ページになっている' do
        expect(current_path).to eq '/posts/followed_index'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    context 'ヘッダーの表示を確認' do
      it 'Homeリンクが表示される: 左上から1番目のリンクが「新しく投稿」である' do
        home_link = find_all('a')[1].native.inner_text
        expect(home_link).to match("新しく投稿")
      end
      it 'Usersリンクが表示される: 左上から2番目のリンクが「マイページ」である' do
        users_link = find_all('a')[2].native.inner_text
        expect(users_link).to match("マイページ")
      end
      it 'Booksリンクが表示される: 左上から3番目のリンクが「みんなの投稿」である' do
        books_link = find_all('a')[3].native.inner_text
        expect(books_link).to match("みんなの投稿")
      end
      it 'log outリンクが表示される: 左上から4番目のリンクが「世界の新着」である' do
        logout_link = find_all('a')[4].native.inner_text
        expect(logout_link).to match("世界の新着")
      end
      it 'log outリンクが表示される: 左上から4番目のリンクが「通知」である' do
        logout_link = find_all('a')[5].native.inner_text
        expect(logout_link).to match("通知")
      end
      it 'log outリンクが表示される: 左上から4番目のリンクが「ログアウト」である' do
        logout_link = find_all('a')[6].native.inner_text
        expect(logout_link).to match("ログアウト")
      end
    end
  end

  describe 'ユーザログアウトのテスト' do
    let(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      logout_link = find_all('a')[6].native.inner_text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている: ログアウト後のリダイレクト先において新規登録画面へのリンクが存在する' do
        expect(page).to have_link '', href: '/users/sign_up'
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end
