require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  context '商品出品できるとき' do
    it '全ての項目が正しく入力されていれば保存できる' do
      expect(@item).to be_valid
    end
  end

  context '商品出品できないとき' do
    it 'nameが空では保存できない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end
    it 'descriptionが空では保存できない' do
      @item.description = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end
    it 'category_idが1では保存できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end
    it 'condition_idが1では保存できない' do
      @item.condition_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Condition can't be blank")
    end
    it 'shipping_fee_idが1では保存できない' do
      @item.shipping_fee_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
    end
    it 'prefecture_idが1では保存できない' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture can't be blank")
    end
    it 'delivery_time_idが1では保存できない' do
      @item.delivery_time_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery time can't be blank")
    end
    it 'priceが空では保存できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end
    it 'priceが300未満だと保存できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
    end
    it 'priceが10000000以上だと保存できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
    end
    it 'priceが半角数字以外だと保存できない（全角など）' do
      @item.price = '１０００'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end
    it 'userが紐づいていないと保存できないと保存でいない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('User must exist')
    end
    it '画像が空では保存できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
  end
end
