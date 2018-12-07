require 'rails_helper'

describe GeneratePhoneService do
  context 'single record' do
    let(:user_name) { 'test name' }
    let(:phone) { nil }
    let(:phone_params) { { user_name: user_name, phone: phone } }
    let(:db_record) { Phone.last }

    it 'creates record for user with first number' do
      expect { described_class.call(phone_params) }.to change(Phone, :count).by(1)
      expect(db_record.phone).to eq Phone::START_PHONE
      expect(db_record.user_name).to eq user_name
      expect(db_record.custom_phone).to be false
    end

    context 'with custom phone' do
      let(:phone) { '123-456-7891' }

      before { described_class.call(phone_params) }

      it 'creates record for user with phone from params' do
        expect(db_record.phone).to eq phone.tr('-', '').to_i
        expect(db_record.user_name).to eq user_name
        expect(db_record.custom_phone).to be true
      end

      context 'custom phone is exists' do
        it 'creates random phone' do
          expect { described_class.call(phone_params) }.to change(Phone, :count).by(1)
          expect(db_record.phone).to eq Phone::START_PHONE
          expect(db_record.user_name).to eq user_name
          expect(db_record.custom_phone).to be false
        end
      end
    end
  end

  context 'multiple records' do
    describe 'request new phone for user' do
      let(:user_name) { 'test name' }
      let(:phone) { nil }
      let(:phone_params) { { user_name: user_name, phone: phone } }
      let(:next_phone) { Phone::START_PHONE + 1 }
      let(:db_record) { Phone.last }

      before { described_class.call(user_name: user_name) }

      it 'creates record with next available phone for user' do
        expect { described_class.call(phone_params) }.to change(Phone, :count).by(1)
        expect(db_record.phone).to eq next_phone
        expect(db_record.user_name).to eq user_name
        expect(db_record.custom_phone).to be false
      end

      context 'with existed next phone' do
        before do
          described_class.call(user_name: user_name)
          described_class.call(user_name: user_name, phone: Phone.stringified(next_phone))
        end

        it 'creates record with next available phone for user' do
          expect { described_class.call(phone_params) }.to change(Phone, :count).by(1)
          expect(db_record.user_name).to eq user_name
          expect(db_record.custom_phone).to be false
        end
      end
    end
  end
end