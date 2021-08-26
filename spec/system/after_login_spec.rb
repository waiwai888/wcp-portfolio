require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  let!(:other_post) { create(:post, user: other_user) }
  let(:tag) { create(:tag) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
      subject { current_path }

      it '新しく投稿を押すと、新規投稿画面に遷移する' do
        home_link = find_all('a')[1].native.inner_text
        home_link = home_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link home_link
        is_expected.to eq '/posts/new'
      end
      it 'マイページを押すと、自分のユーザー詳細画面に遷移する' do
        users_link = find_all('a')[2].native.inner_text
        users_link = users_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link users_link
        is_expected.to eq '/users/' + user.id.to_s
      end
      it 'みんなの投稿を押すと、フォローユーザーの投稿一覧画面に遷移する' do
        books_link = find_all('a')[3].native.inner_text
        books_link = books_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link books_link
        is_expected.to eq '/posts/followed_index'
      end
      it '世界の新着を押すと、全ユーザーの投稿一覧画面に遷移する' do
        books_link = find_all('a')[4].native.inner_text
        books_link = books_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link books_link
        is_expected.to eq '/posts'
      end
      it '通知を押すと、ユーザーの通知一覧画面に遷移する' do
        books_link = find_all('a')[5].native.inner_text
        books_link = books_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link books_link
        is_expected.to eq '/users/' + user.id.to_s '/notifications'
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit posts_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts'
      end
      it '自分と他人の画像のリンク先が正しい' do
        expect(page).to have_link '', href: user_path(post.user)
        expect(page).to have_link '', href: user_path(other_post.user)
      end
      it '自分と他人のニックネームが表示される' do
        expect(page).to have_content post.user.nickname
        expect(page).to have_content other_user.nickname
      end
    end

    context 'タグリストの確認' do
      it 'タグ名が表示される' do
        expect(page).to have_content post.tag_name
      end
      it 'タグ検索へのリンクが存在する' do
        expect(page).to have_link '', href: tag_search_path(tag)
      end
    end

    context '投稿成功のテスト' do
      before do
        fill_in 'post[image]', Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.png'))
        fill_in 'post[body]', with: Faker::Lorem.characters(number: 20)
        fill_in 'tag[tag_name]', with: Faker::Lorem.characters(number: 20)
        fill_in 'posttag[tag_id]', with: FactoryBot.create(:tag).id
        fill_in 'posttag[post_id]', with: FactoryBot.create(:post).id
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '投稿' }.to change(user.posts, :count).by(1)
      end
      it 'リダイレクト先が、全ユーザーの投稿一覧' do
        click_button '投稿'
        expect(current_path).to eq '/posts/' + Post.last.id.to_s
      end
    end
  end

  describe '自分の投稿詳細画面のテスト' do
    before do
      visit post_path(post)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s
      end
      it 'ユーザ画像・名前のリンク先が正しい' do
        expect(page).to have_link book.user.name, href: user_path(post.user)
      end
      it '投稿のbodyが表示される' do
        expect(page).to have_content post.body
      end
      it '投稿の編集リンクが表示される' do
        expect(page).to have_link , href: edit_post_path(book)
      end
      it '投稿の削除リンクが表示される' do
        expect(page).to have_link , href: post_path(book)
      end
    end

    context 'サイドバーの確認' do
      it '「コメント件数」と表示される' do
        expect(page).to have_content 'コメント件数'
      end
      it 'commentフォームが表示される' do
        expect(page).to have_field 'post_comment[comment]'
      end
      it 'commentフォームに値が入っていない' do
        expect(find_field('post_comment[comment]').text).to be_blank
      end
      it 'opinionフォームが表示される' do
        expect(page).to have_field 'post[body]'
      end
      it 'opinionフォームに値が入っていない' do
        expect(find_field('post[body]').text).to be_blank
      end
      it 'コメントするボタンが表示される' do
        expect(page).to have_button 'コメントする'
      end
    end

    context '投稿成功のテスト' do
      before do
        fill_in 'post[image]', Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.png'))
        fill_in 'post[body]', with: Faker::Lorem.characters(number: 20)
        fill_in 'tag[tag_name]', with: Faker::Lorem.characters(number: 20)
        fill_in 'posttag[tag_id]', with: FactoryBot.create(:tag).id
        fill_in 'posttag[post_id]', with: FactoryBot.create(:post).id
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '投稿' }.to change(user.books, :count).by(1)
      end
    end
  end

  describe '自分の投稿編集画面のテスト' do
    before do
      visit edit_post_path(post)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/posts/' + post.id.to_s + '/edit'
      end
      it '「投稿編集」と表示される' do
        expect(page).to have_content '投稿編集'
      end
      it 'tag編集フォームが表示される' do
        expect(page).to have_field 'tag[tag_name]', with: tag.tag_name
      end
      it 'opinion編集フォームが表示される' do
        expect(page).to have_field 'post[body]', with: post.body
      end
      it '更新するボタンが表示される' do
        expect(page).to have_button '更新する'
      end
      it 'Backリンクが表示される' do
        expect(page).to have_link 'back', href: post_path(post)
      end
    end

    context '編集成功のテスト' do
      before do
        @post_old_tag = tag.tag_name
        @post_old_body = post.body
        fill_in 'post[image]', Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.png'))
        fill_in 'post[body]', with: Faker::Lorem.characters(number: 20)
        fill_in 'tag[tag_name]', with: Faker::Lorem.characters(number: 20)
        fill_in 'posttag[tag_id]', with: FactoryBot.create(:tag).id
        fill_in 'posttag[post_id]', with: FactoryBot.create(:post).id
        click_button 'Update Book'
      end

      it 'tagが正しく更新される' do
        expect(post.reload.title).not_to eq @post_old_tag
      end
      it 'bodyが正しく更新される' do
        expect(post.reload.body).not_to eq @post_old_body
      end
      it 'リダイレクト先が、更新した投稿の詳細画面になっている' do
        expect(current_path).to eq '/posts' + post.id.to_s
        expect(page).to have_content '全ユーザーの新着'
      end
    end
  end

  describe 'ユーザ一覧画面のテスト' do
    before do
      visit users_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users'
      end
      it '自分と他人の画像が表示される: fallbackの画像が一覧(2人)の計3つ存在する' do
        expect(all('img').size).to eq(2)
      end
      it '自分と他人の名前がそれぞれ表示される' do
        expect(page).to have_content user.name
        expect(page).to have_content other_user.name
      end
    end
  end

  describe '自分のユーザ詳細画面のテスト' do
    before do
      visit user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it '投稿一覧のユーザ画像のリンク先が正しい' do
        expect(page).to have_link '', href: user_path(user)
      end
      it '投稿一覧に自分の投稿が表示され、リンクが正しい' do
        expect(page).to have_link post, href: post_path(post)
      end
      it '他人の投稿は表示されない' do
        expect(page).not_to have_link '', href: user_path(other_user)
      end
    end

    context 'サイドバーの確認' do
      it '自分の名前と紹介文が表示される' do
        expect(page).to have_content user.name
        expect(page).to have_content user.introduction
      end
      it '自分のユーザ編集画面へのリンクが存在する' do
        expect(page).to have_link '', href: edit_user_path(user)
      end
    end
  end

  describe '自分のユーザ情報編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it 'ニックネーム編集フォームに自分のニックネームが表示される' do
        expect(page).to have_field 'user[nickname]', with: user.nickname
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[profile_image]'
      end
      it '自己紹介編集フォームに自分の自己紹介文が表示される' do
        expect(page).to have_field 'user[introduction]', with: user.introduction
      end
      it 'アカウント名編集フォームに自分のアカウント名が表示される' do
        expect(page).to have_field 'user[account_name]', with: user.account_name
      end
      it '更新するボタンが表示される' do
        expect(page).to have_button '更新する'
      end
    end

    context '更新成功のテスト' do
      before do
        @user_old_name = user.nickname
        @user_old_account_name = user.account_name
        @user_old_intrpduction = user.introduction
        @user_old_profile_image = user.profile_image
        fill_in 'user[profile_image]', Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/no_image.png'))
        fill_in 'user[nickname]', with: Faker::Lorem.characters(number: 9)
        fill_in 'user[account_name]', with: Faker::Lorem.characters(number: 9)
        fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 19)
        click_button '更新する'
      end

      it 'nameが正しく更新される' do
        expect(user.reload.nickname).not_to eq @user_old_nickname
      end
      it 'introductionが正しく更新される' do
        expect(user.reload.introduction).not_to eq @user_old_intrpduction
      end
      it 'account_nameが正しく更新される' do
        expect(user.reload.account_name).not_to eq @user_old_account_name
      end
      it 'profile_imageが正しく更新される' do
        expect(user.reload.profile_image).not_to eq @user_old_profile_image
      end
      it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
        expect(current_path).to eq '/users/' + user.id.to_s
      end
    end
  end
end
