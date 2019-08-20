# frozen_string_literal: true

require "rails_helper"

RSpec.describe "competitions/my_competitions" do
  let(:competition) { FactoryBot.create(:competition, :registration_open, name: "Melbourne Open 2016") }
  let(:registration) { FactoryBot.create(:registration, competition: competition) }
  let(:competition2) { FactoryBot.create(:competition, :visible, name: "Cambridge Open 2020") }

  before do
    allow(view).to receive(:current_user) { registration.user }
    assign(:not_past_competitions, [competition])
    assign(:past_competitions, [])
    assign(:registered_for_by_competition_id, competition.id => registration)
    assign(:bookmarked_competitions, [competition2])
  end

  it "shows upcoming competitions" do
    render
    expect(rendered).to match '<td><a href="/competitions/MelbourneOpen2016">Melbourne Open 2016</a></td>'
  end

  it "shows you are on the waiting list" do
    render
    expect(rendered).to match 'You are currently on the waiting list'
    expect(rendered).to match '<i class="fas fa-hourglass-half"></i>'
  end

  it "shows bookmarked competitions" do
    render
    expect(rendered).to match '<td><a href="/competitions/CambridgeOpen2020">Cambridge Open 2020</a></td>'
  end
end
