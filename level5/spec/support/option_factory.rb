def build_option(id: 1, rental_id: 1, type: :gps)
  Option.new(
    id: id,
    rental_id: rental_id,
    type: type
  )
end