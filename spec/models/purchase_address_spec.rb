require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_address = FactoryBot.build(:purchase_address, user_id: user.id, item_id: item.id)
  end
  describe '購入情報の保存' do
    context '購入できるとき' do
      it 'すべての値が正しく入力されていれば購入できること' do
        expect(@purchase_address).to be_valid
      end
      it '建物は空でも購入できること' do
        @purchase_address.building = ''
        expect(@purchase_address).to be_valid
      end
      it 'phone_numberが10桁でも購入できること' do
        @purchase_address.phone_number = '0312345678' # 固定電話の形式
        expect(@purchase_address).to be_valid
      end

      it 'phone_numberが11桁でも購入できること' do
        @purchase_address.phone_number = '09012345678'
        expect(@purchase_address).to be_valid
      end
    end
  end
  context '購入できないとき' do
    it 'postal_codeが空だと保存できないこと' do
      @purchase_address.postal_code = ''
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include("Postal code can't be blank")
    end
    it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
      @purchase_address.postal_code = '1234567'
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end
    it 'prefectureを選択していないと保存できないこと' do
      @purchase_address.prefecture_id = 1
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include("Prefecture can't be blank")
    end
    it 'phone_numberが空だと保存できないこと' do
      @purchase_address.phone_number = ''
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include("Phone number can't be blank")
    end
    it 'phone_numberが9桁以下だと購入できない' do
      @purchase_address.phone_number = '090123456'
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include('Phone number is invalid. Input only number')
    end

    it 'phone_numberが12桁以上だと購入できない' do
      @purchase_address.phone_number = '090123456789'
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include('Phone number is invalid. Input only number')
    end

    it 'phone_numberにハイフンが含まれていると購入できない' do
      @purchase_address.phone_number = '090-1234-5678'
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include('Phone number is invalid. Input only number')
    end

    it 'phone_numberが全角数字を含むと購入できない' do
      @purchase_address.phone_number = '０９０１２３４５６７８'
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include('Phone number is invalid. Input only number')
    end
    it 'userが紐付いていないと保存できないこと' do
      @purchase_address.user_id = nil
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include("User can't be blank")
    end
    it 'itemが紐付いていないと保存できないこと' do
      @purchase_address.item_id = nil
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include("Item can't be blank")
    end
    it 'tokenが空では保存できないこと' do
      @purchase_address.token = nil
      @purchase_address.valid?
      expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
    end
  end
end
