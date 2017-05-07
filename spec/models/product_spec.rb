# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:cart_items).dependent(:destroy) }
    # it { is_expected.to have_many(:categories) }
  end
end
