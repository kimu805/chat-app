require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe "メッセージ投稿機能" do
    context "メッセージを投稿できる場合" do
      it "contentとimageが存在していれば保存できる" do
        expect(@message).to be_valid
      end
      it "contentが空でも保存できる" do
        @message.content = ""
        expect(@message).to be_valid
      end
      it "imageが空でも保存できる" do
        @message.image = nil
        expect(@message).to be_valid
      end
    end
    context "メッセージを投稿できない場合" do
      it "contentとimageがどちらも空の場合保存できない" do
        @message.content = ""
        @message.image = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Content can't be blank")
      end
      it "roomが紐づいていないと保存できない" do
        @message.room = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Room must exist")
      end
      it "userが紐づいていないと保存できない" do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("User must exist")
      end
    end
  end
end
