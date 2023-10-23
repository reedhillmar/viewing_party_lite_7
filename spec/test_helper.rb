# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/AbcSize

# :nocov:
def load_test_data
  @anne = User.create!(name: "Anne Anderson", email: "anne.anderson@aol.com", password: "test1")
  @blair = User.create!(name: "Blair Busch", email: "Blair@aol.com", password: "test2")
  @cindy = User.create!(name: "Cindy Conners", email: "CC@aol.com", password: 'test3')

  @arthur = ViewingParty.create!(movie_id: 49012, duration: 140, date_time: 10.days.from_now)
  @batman = ViewingParty.create!(movie_id: 268, duration: 240, date_time: 11.days.from_now)
  @candyman = ViewingParty.create!(movie_id: 565028, duration: 380, date_time: 12.days.from_now)
  @dogma = ViewingParty.create!(movie_id: 1832, duration: 400, date_time: 13.days.from_now)

  @host_1 = UserViewingParty.create!(host: true, user: @anne, viewing_party: @arthur)
    @visit_1_1 = UserViewingParty.create!(host: false, user: @blair, viewing_party: @arthur)
    @visit_1_2 = UserViewingParty.create!(host: false, user: @cindy, viewing_party: @arthur)

  @host_2 = UserViewingParty.create!(host: true, user: @anne, viewing_party: @batman)
    @visit_2_1 = UserViewingParty.create!(host: false, user: @blair, viewing_party: @batman)

  @host_3 = UserViewingParty.create!(host: true, user: @blair, viewing_party: @candyman)
    @visit_3_1 = UserViewingParty.create!(host: false, user: @anne, viewing_party: @candyman)
end
# :nocov:

# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/AbcSize
