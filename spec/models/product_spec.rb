require 'rails_helper'

describe Product do
  describe "nil:false" do
    it "全ての項目が入力されていれば登録できること" do
      product = build(:product_image)
      expect(product).to be_valid
    end
    it "画像がない場合保存できない" do
      product = build(:product_image_nil)
      product.valid?
      expect(product.errors[:images]).to include("を入力してください")
    end
    it "商品名がない場合保存できない" do
      product = build(:product, name: "")
      product.valid?
      expect(product.errors[:name]).to include("を入力してください")
    end
    it "商品の説明がない場合保存できない" do
      product = build(:product, text: "")
      product.valid?
      expect(product.errors[:text]).to include("を入力してください")
    end
    it "カテゴリーがない場合保存できない" do
      product = build(:product, category: nil)
      product.valid?
      expect(product.errors[:category]).to include("を入力してください")
    end
    it "商品の状態がない場合保存できない" do
      product = build(:product, status: "")
      product.valid?
      expect(product.errors[:status]).to include("を入力してください")
    end
    it "配送料の負担がない場合保存できない" do
      product = build(:product, shippingcharges: "")
      product.valid?
      expect(product.errors[:shippingcharges]).to include("を入力してください")
    end
    it "配送元の地域がない場合保存できない" do
      product = build(:product, shipping_area: "")
      product.valid?
      expect(product.errors[:shipping_area]).to include("を入力してください")
    end
    it "発送までの日数がない場合保存できない" do
      product = build(:product, days_to_ship: "")
      product.valid?
      expect(product.errors[:days_to_ship]).to include("を入力してください")
    end
    it "価格がない場合保存できない" do
      product = build(:product, price: "")
      product.valid?
      expect(product.errors[:price]).to include("を入力してください")
    end
  end
  describe "price" do
    it "価格が数字でない場合保存できない(aaa)" do
      product = build(:product, price: "aaa")
      product.valid?
      expect(product.errors[:price]).to include("は数値で入力してください")
    end
    it "価格が数字でない場合保存できない(あああ)" do
      product = build(:product, price: "あああ")
      product.valid?
      expect(product.errors[:price]).to include("は数値で入力してください")
    end
  end

  describe "image" do
    it "画像が11枚あるとき保存できない" do
      product = build(:product_11images)
      product.valid?
      expect(product.errors[:images]).to include("は10文字以内で入力してください")
    end
    it "画像が10枚まで保存できる" do
      product = build(:product_10images)
      expect(product).to be_valid
    end
  end
end