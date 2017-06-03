# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TicketsController, type: :request do
  let(:user) { FactoryGirl.create :user }

  describe 'POST #create' do
    context 'as a guest' do
      context 'with valid params' do
        it 'creates new ticket and shows success notification' do
          params = FactoryGirl.attributes_for(:ticket)

          expect do
            post "/tickets", params: { ticket: params, 'HTTP_REFERER' => "/" }
          end.to change(Ticket, :count).by(1)

          expect(response).to redirect_to products_path

          follow_redirect!

          expect(response.body).to include('Ticket submitted')
        end
      end

      context 'with invalid params' do
        %i[content email name].each do |attribute|
          it "does not create ticket and renders new page" do
            params = FactoryGirl.attributes_for(:ticket)
                                .merge(attribute => 'inv')

            expect do
              post "/tickets", params: { ticket: params, 'HTTP_REFERER' => "/" }
            end.not_to change(Ticket, :count)

            expect(response).to redirect_to products_path

            follow_redirect!

            expect(response.body).to include('Invalid ticket')
          end
        end
      end
    end

    context 'as logged in user' do
      before { sign_in user }

      context 'with valid params' do
        it 'creates new ticket and shows success notification' do
          params = FactoryGirl.attributes_for(:ticket)
                              .merge({name: user.name, email: user.email})

          expect do
            post "/tickets", params: { ticket: params }
          end.to change(Ticket, :count).by(1)

          new_ticket = Ticket.last

          expect(new_ticket.user).to eq(user)
          expect(new_ticket.email).to eq(user.email)
          expect(new_ticket.name).to eq(user.name)
          expect(user.tickets).to include(new_ticket)
        end
      end
    end
  end
end
