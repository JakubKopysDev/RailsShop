# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_one(:cart).dependent(:destroy) }
    it { is_expected.to have_many(:cart_items).through(:cart) }
  end
end
