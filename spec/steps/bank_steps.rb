steps_for :jpb do
  step 'ゆうちょ銀行のサイトを表示する' do
    visit 'http://www.jp-bank.japanpost.jp/'
    sleep 1
  end

  step 'ログインボタンをクリックする' do
    find('img[alt="ゆうちょダイレクト　ログイン"]').click
  end

  step 'お客様番号を入力し次へすすむ' do
    expect(page).to have_content 'お客さま番号を入力し、「次へ」をクリックしてください。'

    fill_in 'okyakusamaBangou1', with: Settings.jpb_customer_nos[0]
    fill_in 'okyakusamaBangou2', with: Settings.jpb_customer_nos[1]
    fill_in 'okyakusamaBangou3', with: Settings.jpb_customer_nos[2]
    click_on '次へ'
    sleep 1
  end

  step 'もし合言葉入力画面が表示されていたら、合言葉を入力し次へすすむ' do
    while aikotoba = Settings.jpb.aikotoba.select {|aikotoba| page.has_content?(aikotoba['q']) }.first
      fill_in 'aikotoba', with: aikotoba['a']
      click_on '次へ'
      sleep 1
    end
  end

  step 'パスワードを入力してログインする' do
    expect(page).to have_content '画像をご確認のうえ、ログインパスワードを入力して、「ログイン」をクリックしてください。'
    fill_in 'loginPassword', with: Settings.jpb.password
    click_on 'ログイン'
    expect(page).to have_content 'お取引を終了される場合は、必ず「ログアウト」をクリックしてください。'
  end

  step 'ゆうちょダイレクトにログインする' do
    send 'ゆうちょ銀行のサイトを表示する'
    send 'ログインボタンをクリックする'
    send 'お客様番号を入力し次へすすむ'
    send 'もし合言葉入力画面が表示されていたら、合言葉を入力し次へすすむ'
    send 'パスワードを入力してログインする'
  end

  step 'ゆうちょダイレクトの残高を確認する' do
    click_on 'メインメニュー'
    click_on '現在高照会'
    @balance = jpy find('.formselector tr:last-child .intcell').text
  end

  step '銀行口座に家賃分の残高がある' do
    send 'ゆうちょダイレクトにログインする'
    send 'ゆうちょダイレクトの残高を確認する'
    expect(@balance > @rent).to be_true
  end
end
